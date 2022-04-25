# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Organization Following
    module OrganizationFollowing
      ###################################################
      # Organization Following
      ###################################################

      # Organization Following Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowing)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Following Enumerator object
      def iter_organization_following(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/following").each do |e|
            yielder.yield e
          end
        end
      end

      # Organization Followers Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/removeOrganizationFollowingById)
      #
      # @param organization_id [UUID] of the organization
      # @param following_id [UUID] of the follower
      #
      # @return a Boolean with result
      def stop_organization_following(organization_id, following_id)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/following/#{validate_uuid(following_id)}")
      end

      ###################################################
      # Organization Following Request
      ###################################################

      # Organization Following Requests Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowingRequests)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Following Requests Enumerator object
      def iter_organization_following_requests(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/following/requests").each do |e|
            yielder.yield e
          end
        end
      end

      # Returns a request received by an organization to follow another
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationFollowingRequestByToken)
      #
      # @param organization_id [UUID] of the organization
      # @param following_id [UUID] of the follower request
      #
      # @return an Object representing the organization following request
      def get_organization_following_request(organization_id, following_id)
        @http.request(
          'GET',
          "/organizations/#{validate_uuid(organization_id)}/following/requests/#{validate_uuid(following_id)}"
        )
      end

      # Accepts a request to follow another organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/acceptOrganizationFollowingRequestByToken)
      #
      # @param organization_id [UUID] of the organization who was invited to follow another
      # @param following_id [UUID] of the organization who is going to be followed
      #
      # @return an Object describing the newly established following relationship
      def accept_organization_following_request(organization_id, following_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/following/requests/#{validate_uuid(following_id)}/accept"
        )
      end

      # Declines a request to follow another organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/declineOrganizationFollowingRequestByToken)
      #
      # @param organization_id [UUID] of the organization who was invited to follow another
      # @param following_id [UUID] of the organization who is going to be followed
      #
      # @return an Object describing the newly established following relationship
      def decline_organization_following_request(organization_id, following_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/following/requests/#{validate_uuid(following_id)}/decline"
        )
      end
    end
  end
end
