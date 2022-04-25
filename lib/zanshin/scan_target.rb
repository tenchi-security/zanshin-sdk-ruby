# frozen_string_literal: true

require 'json'

module Zanshin
  module SDK
    # Zanshin SDK Scan Target
    #
    # This module contains the classes for each provider that Zanshin supports, and which can be used
    #   to create a scan target
    module ScanTarget
      # AWS scan target
      class AWS
        # Type of provider that will be sent to the API
        KIND = 'AWS'

        attr_accessor :account

        def initialize(account)
          @account = account
        end

        # Convert AWS class to json
        def to_json(*_args)
          {
            'account' => @account
          }
        end
      end

      # Azure scan target
      class Azure
        # Type of provider that will be sent to the API
        KIND = 'Azure'

        attr_accessor :application_id, :subscription_id, :directory_id, :secret

        def initialize(application_id, subscription_id, directory_id, secret)
          @application_id = application_id
          @subscription_id = subscription_id
          @directory_id = directory_id
          @secret = secret
        end

        # Convert Azure class to json
        def to_json(*_args)
          {
            'application_id' => @application_id,
            'subscription_id' => @subscription_id,
            'directory_id' => @directory_id,
            'secret' => @secret
          }
        end
      end

      # GCP scan target
      class GCP
        # Type of provider that will be sent to the API
        KIND = 'GCP'

        attr_accessor :project_id

        def initialize(project_id)
          @project_id = project_id
        end

        # Convert GCP class to json
        def to_json(*_args)
          {
            'project_id' => @project_id
          }
        end
      end

      # HUAWEI scan target
      class HUAWEI
        # Type of provider that will be sent to the API
        KIND = 'HUAWEI'

        attr_accessor :account_id

        def initialize(account_id)
          @account_id = account_id
        end

        # Convert HUAWEI class to json
        def to_json(*_args)
          {
            'account_id' => @account_id
          }
        end
      end

      # DOMAIN scan target
      class DOMAIN
        # Type of provider that will be sent to the API
        KIND = 'DOMAIN'

        attr_accessor :domain

        def initialize(domain)
          @domain = domain
        end

        # Convert DOMAIN class to json
        def to_json(*_args)
          {
            'domain' => @domain
          }
        end
      end
    end
  end
end
