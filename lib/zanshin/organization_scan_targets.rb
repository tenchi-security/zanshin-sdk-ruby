# frozen_string_literal: true

require_relative 'scan_target'

module Zanshin
  module SDK
    # Zanshin SDK Organization Scan Target
    module OrganizationScanTargets
      ###################################################
      # Organization Scan Targets
      ###################################################

      # Scan Targets Enumerator of an organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationScanTargets)
      #
      # @param organization_id [UUID] of the organization
      #
      # @return an Scan Targets Enumerator object
      def iter_organization_scan_targets(organization_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/organizations/#{validate_uuid(organization_id)}/scantargets").each do |e|
            yielder.yield e
          end
        end
      end

      # Create a new scan target in organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/createOrganizationScanTargets)
      #
      # @param organization_id [UUID] of the organization
      # @param name [UUID] of the organization
      # @param credential [ScanTarget::AWS, ScanTarget::Azure, ScanTarget::GCP, ScanTarget::HUAWEI, ScanTarget::DOMAIN]
      #   to access the cloud account to be scanned
      # @param schedule [Cron] in cron format
      #
      # @return an Object representing the newly created scan target
      def create_organization_scan_target(organization_id, name, credential, schedule = '0 0 * * *')
        unless [ScanTarget::AWS, ScanTarget::Azure, ScanTarget::GCP,
                ScanTarget::HUAWEI, ScanTarget::DOMAIN].include? credential.class
          raise "#{credential.class} is invalid instance of Zanshin::SDK::ScanTarget classes"
        end

        body = {
          'kind' => credential.class::KIND, 'name' => name,
          'credential' => credential.to_json, 'schedule' => schedule
        }
        @http.request('POST', "/organizations/#{validate_uuid(organization_id)}/scantargets", body)
      end

      # Get scan target details of organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationScanTargetById)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return a Object representing the scan target
      def get_organization_scan_target(organization_id, scan_target_id)
        @http.request('GET',
                      "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}")
      end

      # Update scan target of organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/editOrganizationMembersById)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      # @param name [String] of the scan target
      # @param schedule [Cron] of the schedule
      #
      # @return a Object representing the scan target updated
      def update_organization_scan_target(organization_id, scan_target_id, name = nil, schedule = nil)
        body = {
          'name' => name,
          'schedule' => schedule
        }

        @http.request('PUT',
                      "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}",
                      body)
      end

      # Delete scan target of organization
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/deleteOrganizationScanTargetById)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return a Boolean with result
      def delete_organization_scan_target(organization_id, scan_target_id)
        @http.request('DELETE',
                      "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}")
      end

      # Starts a scan on the specified scan target
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/scanOrganizationScanTarget)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return a Boolean with result
      def start_organization_scan_target_scan(organization_id, scan_target_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}/scan"
        )
      end

      # TODO: API documentation is not up to date, does not have this endpoint
      #   After updating you will need to add the reference here

      # Stop a scan on the specific scan target
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return a Boolean with result
      def stop_organization_scan_target_scan(organization_id, scan_target_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}/stop"
        )
      end

      # Check scan target
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/checkOrganizationScanTarget)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return a Object representing the scan target
      def check_organization_scan_target(organization_id, scan_target_id)
        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}/check"
        )
      end

      ###################################################
      # Organization Scan Target Scan
      ###################################################

      # Scans Enumerator of an Scan Target
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationScanTargetScans)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      #
      # @return an Scans Enumerator object
      def iter_organization_scan_target_scans(organization_id, scan_target_id)
        Enumerator.new do |yielder|
          @http.request(
            'GET',
            "/organizations/#{validate_uuid(organization_id)}/scantargets/#{validate_uuid(scan_target_id)}/scans"
          ).each do |e|
            yielder.yield e
          end
        end
      end

      # Get scan of scan target
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getOrganizationScanTargetScanSlot)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      # @param scan_id [UUID] of the scan
      #
      # @return a Object representing the scan
      def get_organization_scan_target_scan(organization_id, scan_target_id, scan_id)
        @http.request(
          'GET',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{
            validate_uuid(scan_target_id)}/scans/#{validate_uuid(scan_id)}"
        )
      end
    end
  end
end
