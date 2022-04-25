# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Summary
    module Summaries
      ###################################################
      # Summaries
      ###################################################

      # Gets a summary of the current state of alerts for an organization, both in total and broken down by scan target
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/alertSummary)
      #
      # @param organization_id [UUID] of the organization whose alert summaries are desired
      # @param scan_target_ids [Array<UUID>] optional list of scan target IDs to summarize alerts from, defaults to all
      #
      # @return a Object representing the alert summaries
      def get_alert_summaries(organization_id, scan_target_ids = [])
        body = {
          'organizationId' => validate_uuid(organization_id),
          'scanTargetIds' => scan_target_ids.each { |scan_target_id| validate_uuid(scan_target_id) }
        }

        @http.request('POST', '/alerts/summaries', body)
      end

      # Gets a summary of the current state of alerts for followed organizations
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/alertFollowingSummary)
      #
      # @param organization_id [UUID] of the organization
      # @param following_ids [Array<UUID>] list of IDs of organizations being followed to summarize alerts from
      #
      # @return a Object representing the alert following summaries
      def get_following_alert_summaries(organization_id, following_ids = [])
        body = {
          'organizationId' => validate_uuid(organization_id),
          'followingIds' => following_ids.each { |following_id| validate_uuid(following_id) }
        }

        @http.request('POST', '/alerts/summaries/following', body)
      end

      # Returns summaries of scan results over a period of time, summarizing number of alerts that changed states
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/scanSummary)
      #
      # @param organization_id [UUID] of the organization whose alert summaries are desired
      # @param scan_target_ids [Array<UUID>] optional list of scan target IDs to summarize alerts from, defaults to all
      # @param days [Integer] number of days to go back in time in historical search
      #
      # @return a Object representing the scan summaries
      def get_scan_summaries(organization_id, scan_target_ids = [], days = 7)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'scanTargetIds' => scan_target_ids.each { |scan_target_id| validate_uuid(scan_target_id) },
          'daysBefore' => days
        }

        @http.request('POST', '/alerts/summaries/scans', body)
      end

      # Gets a summary of the current state of alerts for followed organizations
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/scanSummaryFollowing)
      #
      # @param organization_id [UUID] of the organization whose alert summaries are desired
      # @param following_ids [Array<UUID>] optional list of IDs of organizations being followed to summarize alerts from
      # @param days [Integer] number of days to go back in time in historical search
      #
      # @return a Object representing the scan summaries
      def get_following_scan_summaries(organization_id, following_ids = [], days = 7)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'followingIds' => following_ids.each { |following_id| validate_uuid(following_id) },
          'daysBefore' => days
        }

        @http.request('POST', '/alerts/summaries/scans/following', body)
      end
    end
  end
end
