# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Account
    module Account
      ###################################################
      # Account
      ###################################################

      # Returns the details of the user account that owns the API key used by this Connection instance
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getMe)
      #
      # @return an Object representing the user
      def get_me
        @http.request('GET', '/me')
      end

      ###################################################
      # Account Invites
      ###################################################

      # Invites Enumerator of current logged user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getInvites)
      #
      # @return an Invites Enumerator object
      def iter_invites
        Enumerator.new do |yielder|
          @http.request('GET', '/me/invites').each do |e|
            yielder.yield e
          end
        end
      end

      # Gets a specific invitation details, it only works if the invitation was made for the current logged user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getInviteById)
      #
      # @param invite_id [UUID] of the invite
      #
      # @return an Object representing the invite
      def get_invite(invite_id)
        @http.request('GET', "/me/invites/#{validate_uuid(invite_id)}")
      end

      # Accepts an invitation with the informed ID, it only works if the user accepting the invitation is the user that
      #   received the invitation
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/acceptInviteById)
      #
      # @param invite_id [UUID] of the invite
      #
      # @return an Object representing the organization of this invite
      def accept_invite(invite_id)
        @http.request('POST', "/me/invites/#{validate_uuid(invite_id)}/accept")
      end

      ###################################################
      # Account API key
      ###################################################

      # API keys Enumerator of current logged user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getMyApiKeys)
      #
      # @return an API keys Enumerator object
      def iter_api_keys
        Enumerator.new do |yielder|
          @http.request('GET', '/me/apikeys').each do |e|
            yielder.yield e
          end
        end
      end

      # Creates a new API key for the current logged user, API Keys can be used to interact with the zanshin api
      #   directly on behalf of that user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/createApiKeys)
      #
      # @param name [String] of your new API key
      #
      # @return an Object representing the user api key
      def create_api_key(name)
        body = {}
        body['name'] = name
        @http.request('POST', '/me/apikeys', body)
      end

      # Deletes a given API key by its id, it will only work if the informed ID belongs to the current logged user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/deleteApiKey)
      #
      # @param api_key_id [UUID] of your new API key
      #
      # @return a Boolean with result
      def delete_api_key(api_key_id)
        @http.request('DELETE', "/me/apikeys/#{validate_uuid(api_key_id)}")
      end
    end
  end
end
