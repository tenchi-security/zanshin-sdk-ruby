# frozen_string_literal: true

require 'configparser'
require 'uri'
require 'logger'

require_relative 'request/zanshin_request'
require_relative 'account'
require_relative 'alerts'
require_relative 'organization_followers'
require_relative 'organization_following'
require_relative 'organization_members'
require_relative 'organization_scan_targets'
require_relative 'organizations'
require_relative 'summaries'

module Zanshin
  module SDK
    # Zanshin SDK Client
    class Client
      include Zanshin::SDK::Account
      include Zanshin::SDK::Alerts
      include Zanshin::SDK::Organizations
      include Zanshin::SDK::OrganizationFollowers
      include Zanshin::SDK::OrganizationFollowing
      include Zanshin::SDK::OrganizationMembers
      include Zanshin::SDK::OrganizationScanTargets
      include Zanshin::SDK::Summaries

      # @overload api_key
      #   Gets the current value of api_key
      #   @return api_key
      # @overload api_key=(value)
      #   Sets the api_key
      #   @param [value] the new api_key
      attr_reader :api_key
      # @overload api_url
      #   Gets the current value of api_url
      #   @return api_url
      # @overload api_url=(value)
      #   Sets the api_url
      #   @param [value] the new api_url
      attr_reader :api_url
      # @overload user_agent
      #   Gets the current value of user_agent
      #   @return user_agent
      # @overload user_agent=(value)
      #   Sets the user_agent
      #   @param [value] the new user_agent
      attr_reader :user_agent
      # @overload proxy_url
      #   Gets the current value of proxy_url
      #   @return proxy_url
      # @overload proxy_url=(value)
      #   Sets the proxy_url
      #   @param [value] the new proxy_url
      attr_reader :proxy_url

      # @overload http
      #   Gets the current value of http
      #   @return http
      # @overload http=(`:HTTPClient`)
      #   Sets the http
      #   @param [value] the new http
      attr_accessor :http

      # Initialize a new Zanshin SDK instance
      # @overload initialize(profile, api_key, api_url, user_agent, proxy_url)
      #   @param profile [String] Which configuration file section to use for settings
      #   @param api_key [String] Optional override of the API key to use
      #   @param api_url [String] Optional override of the base URL of the Zanshin API to use
      #   @param user_agent [String] Optional addition of the user agent to use in requests performed
      #   @param proxy_url [String] Optional URL indicating which proxy server to use
      def initialize(profile: 'default',
                     api_key: ENV.fetch('ZANSHIN_API_KEY', nil),
                     api_url: ENV.fetch('ZANSHIN_API_URL', nil) || ZANSHIN_API,
                     user_agent: ENV.fetch('ZANSHIN_USER_AGENT', nil),
                     proxy_url: ENV.fetch('HTTP_PROXY', ENV.fetch('HTTPS_PROXY', nil)))
        @logger = Logger.new($stdout)
        @logger.level = Logger::WARN

        config = get_config(profile)

        @api_key = api_key || config['api_key'] || raise('No API key found')
        @api_url = validate_url(api_url || config['api_url'])
        @user_agent = add_sdk_agent(user_agent || config['user_agent'])
        @proxy_url = validate_proxy(proxy_url || config['proxy_url'])

        update_request
        @logger.debug('Zanshin SDK Initialized')
      end

      def api_key=(value)
        raise('API key cannot be nil') unless value

        @api_key = value

        update_request
      end

      def api_url=(value)
        @api_url = validate_url(value)

        update_request
      end

      def user_agent=(value)
        @user_agent = add_sdk_agent(value)

        update_request
      end

      def proxy_url=(value)
        @proxy_url = validate_proxy(value)

        update_request
      end

      private

      attr_accessor :logger

      # Internal method to read user configuration file
      def get_config(profile)
        parser = if File.exist?(File.expand_path(CONFIG_FILE))
                   ConfigParser.new(CONFIG_FILE)
                 else
                   raise("Not found #{CONFIG_FILE}")
                 end
        raise "Profile #{profile} not found in #{CONFIG_FILE}" unless parser[profile]

        parser[profile]
      end

      # Internal method to validate URL
      def validate_url(url)
        raise 'API URL cannot be nil' unless url

        uri = URI(url)
        if (uri.scheme != 'https') ||
           !uri.host ||
           (uri.password || uri.user) ||
           !uri.port.between?(0, 65_535)
          raise "Invalid API URL: #{url}"
        end

        url
      end

      # Internal method to validate proxy
      def validate_proxy(proxy_url)
        return nil unless proxy_url

        proxy = URI(proxy_url)
        if !(%w[http https].include? proxy.scheme) ||
           !proxy.host ||
           (proxy.user && !proxy.password) ||
           !proxy.port.between?(0, 65_535)
          raise "Invalid proxy URL: #{proxy_url}"
        end

        proxy_url
      end

      # Internal method to concatenate user-agent with SDK pattern
      def add_sdk_agent(agent)
        if agent.to_s.strip.empty?
          "Zanshin Ruby SDK #{Zanshin::SDK::VERSION}"
        else
          "#{agent}/Zanshin Ruby SDK #{Zanshin::SDK::VERSION}"
        end
      end

      # Internal method to create a new pre-configured Zanshin::SDK::Request::HTTPClient instance when one
      #   of the relevant settings is changed (API key, API URL, user-agent or Proxy URL).
      def update_request
        @http = Zanshin::SDK::Request::HTTPClient.new(@api_key, @api_url, @user_agent, @proxy_url)
      end

      # Internal method to validate UUID
      def validate_uuid(uuid)
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
        raise "#{uuid} is not a valid UUID" unless uuid_regex.match?(uuid.to_s.downcase)

        uuid
      end
    end
  end
end
