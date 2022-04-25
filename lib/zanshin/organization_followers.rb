# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Organization Followers
    module OrganizationFollowers
      ###################################################
      # Organization Follower
      ###################################################

      # Organization Followers Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowers)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Followers Enumerator object
      def iter_organization_followers(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/followers").each do |e|
            yielder.yield e
          end
        end
      end

      # Organization Followers Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowers)
      #
      # @param organization_id [UUID] of the organization
      # @param follower_id [UUID] of the follower
      #
      # @return a Boolean with result
      def stop_organization_follower(organization_id, follower_id)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/followers/#{validate_uuid(follower_id)}")
      end

      ###################################################
      # Organization Follower Request
      ###################################################

      # Organization Followers Requests Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowRequests)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Followers Requests Enumerator object
      def iter_organization_follower_requests(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/followers/requests").each do |e|
            yielder.yield e
          end
        end
      end

      # Create organization follower request
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/createOrganizationFollowRequests)
      #
      # @param organization_id [UUID] of the organization
      # @param token [UUID] of the follower request
      #
      # @return an Organization Followers Requests Enumerator object
      def create_organization_follower_request(organization_id, token)
        body = {
          'token' => validate_uuid(token)
        }
        @http.request('POST', "/organizations/#{validate_uuid(organization_id)}/followers/requests", body)
      end

      # Get organization follower request
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowRequestsByToken)
      #
      # @param organization_id [UUID] of the organization
      # @param token [UUID] of the follower request
      #
      # @return an Object representing the organization follower
      def get_organization_follower_request(organization_id, token)
        @http.request('GET',
                      "/organizations/#{validate_uuid(organization_id)}/followers/requests/#{validate_uuid(token)}")
      end

      # Delete organization follower request
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/deleteOrganizationFollowRequestsbyToken)
      #
      # @param organization_id [UUID] of the organization
      # @param token [UUID] of the follower request
      #
      # @return a Boolean with result
      def delete_organization_follower_request(organization_id, token)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/followers/requests/#{validate_uuid(token)}")
      end
    end
  end
end
