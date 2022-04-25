# frozen_string_literal: true

require 'net/http'
require 'zanshin/request/zanshin_request_error'
require 'json'

module Zanshin
  module SDK
    # Zanshin SDK Request
    module Request
      # Zanshin SDK request HTTPClient
      class HTTPClient
        attr_accessor :headers, :http_client

        # Initialize a new HTTP connection to the Zanshin API
        # @overload initialize(api_key, api_url, user_agent, proxy_url)
        #   @param api_key [String] API key to use
        #   @param api_url [String] URL of the Zanshin API
        #   @param user_agent [String] User agent to use in requests performed
        #   @param proxy_url [String] Optional URL indicating which proxy server to use
        def initialize(api_key, api_url, user_agent, proxy_url = nil)
          @headers = { 'Authorization' => "Bearer #{api_key}",
                       'User-Agent' => user_agent,
                       'Content-Type' => 'application/json' }
          # HACK: Needs to figure out why Net::HTTP is not automatically decoded `gzip` and `deflate` encoding
          # 'Accept-Encoding' => 'gzip, deflate'

          uri = URI.parse(api_url)
          proxy = URI.parse(proxy_url || '')

          @http_client = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
          @http_client.use_ssl = true
        end

        # Request to Zanshin
        # @overload initialize(api_key, api_url, user_agent, proxy_url)
        #   @param method ['GET', 'POST', 'PUT', 'DELETE'] HTTP method to pass along to `:HTTPClient`
        #   @param path [String] API path to access
        #   @param body [Object] request body to pass along to `:HTTPClient`
        def request(method, path, body = nil)
          body = body.to_json if body
          response = @http_client.send_request(method, path, body, @headers)
          result = JSON.parse(response.body)
          raise ZanshinError.new(response.code, result['message'] || result['errorName']) if response.code.to_i >= 400

          result
        end
      end
    end
  end
end
