# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Organization
    module Organizations
      ###################################################
      # Organizations
      ###################################################

      # Organizations Enumerator of current logged user
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizations)
      #
      # @return an Organizations Enumerator object
      def iter_organizations
        Enumerator.new do |yielder|
          @http.request('GET', '/organizations').each do |e|
            yielder.yield e
          end
        end
      end

      # Gets an organization given its ID
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationById)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Object representing the organization
      def get_organization(organization_id)
        @http.request('GET', "/organizations/#{validate_uuid(organization_id)}")
      end

      # Gets an organization given its ID
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/editOrganizationById)
      #
      # @param organization_id [UUID] of the organization
      # @param name [String] Optional name of the organization
      # @param picture [String] Optional picture URL of the organization, accepted formats: jpg, jpeg, png, svg
      # @param email [String] Optional e-mail contact of the organization
      #
      # @return an Object representing the organization
      def update_organization(organization_id, name: nil, picture: nil, email: nil)
        body = {
          'name' => name,
          'picture' => picture,
          'email' => email
        }
        @http.request('PUT', "/organizations/#{validate_uuid(organization_id)}", body)
      end
    end
  end
end
