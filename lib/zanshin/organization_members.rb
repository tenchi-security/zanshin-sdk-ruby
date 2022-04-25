# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Organization Members
    module OrganizationMembers
      ###################################################
      # Organization Member
      ###################################################

      # Organization Members Enumerator of the users which are members of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationMembers)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Members Enumerator object
      def iter_organization_members(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/members").each do |e|
            yielder.yield e
          end
        end
      end

      # Get details on a user's organization membership
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationMemberById)
      #
      # @param organization_id [UUID] of the organization
      # @param member_id [UUID] of the member
      #
      # @return a Object representing the organization member
      def get_organization_member(organization_id, member_id)
        @http.request('GET',
                      "/organizations/#{validate_uuid(organization_id)}/members/#{validate_uuid(member_id)}")
      end

      # Update organization member
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/editOrganizationMembersById)
      #
      # @param organization_id [UUID] of the organization
      # @param member_id [UUID] of the member
      # @param roles ['ADMIN'] of the member
      #
      # @return a Object representing the organization member
      def update_organization_member(organization_id, member_id, roles = nil)
        body = {
          'roles' => [roles].compact
        }
        @http.request('PUT',
                      "/organizations/#{validate_uuid(organization_id)}/members/#{validate_uuid(member_id)}",
                      body)
      end

      # Delete organization member
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/removeOrganizationMemberById)
      #
      # @param organization_id [UUID] of the organization
      # @param member_id [UUID] of the member
      #
      # @return a Boolean with result
      def delete_organization_member(organization_id, member_id)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/members/#{validate_uuid(member_id)}")
      end

      # Reset organization member MFA
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/resetOrganizationMemberMfaById)
      #
      # @param organization_id [UUID] of the organization
      # @param member_id [UUID] of the member
      #
      # @return a Boolean with result
      def reset_organization_member_mfa(organization_id, member_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/members/#{validate_uuid(member_id)}/mfa/reset"
        )
      end

      # Reset organization member Password
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/resetOrganizationMemberPasswordById)
      #
      # @param organization_id [UUID] of the organization
      # @param member_id [UUID] of the member
      #
      # @return a Boolean with result
      def reset_organization_member_password(organization_id, member_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/members/#{validate_uuid(member_id)}/password/reset"
        )
      end

      ###################################################
      # Organization Member Invite
      ###################################################

      # Organization Members Invites Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrgamizationInvites)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Organization Members Invites Enumerator object
      def iter_organization_members_invites(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/invites").each do |e|
            yielder.yield e
          end
        end
      end

      # Create organization member invite
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/createOrgamizationInvite)
      #
      # @param organization_id [UUID] of the organization
      # @param email [String] of the new member
      # @param roles ['ADMIN'] of the new member
      #
      # @return a Object representing the organization member invite
      def create_organization_members_invite(organization_id, email, roles = nil)
        body = {
          'email' => email,
          'roles' => [roles].compact
        }
        @http.request('POST',
                      "/organizations/#{validate_uuid(organization_id)}/invites",
                      body)
      end

      # Get organization member invite
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationInviteByEmail)
      #
      # @param organization_id [UUID] of the organization
      # @param email [String] of the invited member
      #
      # @return a Object representing the organization member invite
      def get_organization_member_invite(organization_id, email)
        @http.request('GET',
                      "/organizations/#{validate_uuid(organization_id)}/invites/#{email}")
      end

      # Delete organization member invite
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/deleteOrganizationInviteByEmail)
      #
      # @param organization_id [UUID] of the organization
      # @param email [String] of the invited member
      #
      # @return a Boolean with result
      def delete_organization_member_invite(organization_id, email)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/invites/#{email}")
      end

      # Resend organization member invitation
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/resendOrganizationInviteByEmail)
      #
      # @param organization_id [UUID] of the organization
      # @param email [String] of the invited member
      #
      # @return a Boolean with result
      def resend_organization_member_invite(organization_id, email)
        @http.request('POST',
                      "/organizations/#{validate_uuid(organization_id)}/invites/#{email}/resend")
      end
    end
  end
end
