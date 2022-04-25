# frozen_string_literal: true

module Zanshin
  module SDK
    # Zanshin SDK Alerts
    module Alerts
      ###################################################
      # Alerts
      ###################################################

      # Alerts Enumerator of an organization by loading them, transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlert)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_ids [Array<UUID>] Optional list of scan target IDs to list alerts from, defaults to all
      # @param rule [String] to filter alerts from (rule), not passing the field will fetch all
      # @param states [Array<'OPEN', 'ACTIVE', 'IN_PROGRESS', 'RISK_ACCEPTED', 'CLOSED'>] Optional list of states to
      #   filter returned alerts, defaults to all
      # @param severities [Array<'CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'INFO'>] optional list of severities to filter
      #   returned alerts, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      # @param language ['en-US', 'pt-BR'] Language of the rule will be returned
      # @param created_at_start [String] Search alerts by creation date - greater or equals than
      # @param created_at_end [String] Search alerts by creation date - less or equals than
      # @param updated_at_start [String] Search alerts by update date - greater or equals than
      # @param updated_at_end [String] Search alerts by update date - less or equals than
      #
      # @return an Alerts Enumerator object
      def iter_alerts(organization_id,
                      scan_target_ids: [],
                      rule: nil,
                      states: nil,
                      severities: nil,
                      page_size: 100,
                      language: nil,
                      created_at_start: nil,
                      created_at_end: nil,
                      updated_at_start: nil,
                      updated_at_end: nil)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'scanTargetIds' => scan_target_ids.each { |scan_target_id| validate_uuid(scan_target_id) },
          'rule' => rule,
          'states' => states,
          'severities' => severities,
          'lang' => language,
          'CreatedAtStart' => created_at_start,
          'CreatedAtEnd' => created_at_end,
          'UpdatedAtStart' => updated_at_start,
          'UpdatedAtEnd' => updated_at_end
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts', body.compact)
            data['data'].each do |e|
              yielder.yield e
            end
            break if body['page'] == (data['total'] / body['pageSize']).ceil
          end
        end
      end

      # Alerts Following Enumerator over the following alerts froms organizations being followed by
      #   transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listFollowingAlerts)
      #
      # @param organization_id [UUID] of the organization
      # @param following_ids [Array<UUID>] Optional list of IDs of organizations you are following to
      #   list alerts from, defaults to all
      # @param rule [String] to filter alerts from (rule), not passing the field will fetch all
      # @param states [Array<'OPEN', 'ACTIVE', 'IN_PROGRESS', 'RISK_ACCEPTED', 'CLOSED'>] Optional list of states to
      #   filter returned alerts, defaults to all
      # @param severities [Array<'CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'INFO'>] optional list of severities to filter
      #   returned alerts, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      # @param language ['en-US', 'pt-BR'] Language of the rule will be returned
      # @param created_at_start [String] Search alerts by creation date - greater or equals than
      # @param created_at_end [String] Search alerts by creation date - less or equals than
      # @param updated_at_start [String] Search alerts by update date - greater or equals than
      # @param updated_at_end [String] Search alerts by update date - less or equals than
      #
      # @return an Alerts Enumerator object
      def iter_following_alerts(organization_id,
                                following_ids: [],
                                rule: nil,
                                states: nil,
                                severities: nil,
                                page_size: 100,
                                language: nil,
                                created_at_start: nil,
                                created_at_end: nil,
                                updated_at_start: nil,
                                updated_at_end: nil)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'followingIds' => following_ids.each { |following_id| validate_uuid(following_id) },
          'rule' => rule,
          'states' => states,
          'severities' => severities,
          'lang' => language,
          'CreatedAtStart' => created_at_start,
          'CreatedAtEnd' => created_at_end,
          'UpdatedAtStart' => updated_at_start,
          'UpdatedAtEnd' => updated_at_end
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts/following', body.compact)
            data['data'].each do |e|
              yielder.yield e
            end
            break if body['page'] == (data['total'] / body['pageSize']).ceil
          end
        end
      end

      # Alerts History Enumerator of an organization by loading them, transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertsHistory)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_ids [Array<UUID>] Optional list of scan target IDs to list alerts from, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      # @param language ['en-US', 'pt-BR'] Language of the rule will be returned
      # @param cursor [String] Alert Cursor of the last alert consumed, when this value is passed, subsequent
      #   alert histories will be returned
      #
      # @return an Alerts History Enumerator object
      def iter_alerts_history(organization_id,
                              scan_target_ids: [],
                              page_size: 100,
                              language: nil,
                              cursor: nil)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'scanTargetIds' => scan_target_ids.each { |scan_target_id| validate_uuid(scan_target_id) },
          'lang' => language,
          'cursor' => cursor
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts/history', body.compact)
            break if data['data'].empty?

            body['cursor'] = data['data'].last['cursor']
            data['data'].each do |e|
              yielder.yield e
            end
          end
        end
      end

      # Alerts Following History Enumerator of an organization by loading them, transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertsHistoryFollowing)
      #
      # @param organization_id [UUID] of the organization
      # @param following_ids [Array<UUID>] Optional list of IDs of organizations you are following to
      #   list alerts from, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      # @param language ['en-US', 'pt-BR'] Language of the rule will be returned
      # @param cursor [String] Alert Cursor of the last alert consumed, when this value is passed, subsequent
      #   alert histories will be returned
      #
      # @return an Alerts Following History Enumerator object
      def iter_alerts_following_history(organization_id,
                                        following_ids: [],
                                        page_size: 100,
                                        language: nil,
                                        cursor: nil)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'followingIds' => following_ids.each { |following_id| validate_uuid(following_id) },
          'lang' => language,
          'cursor' => cursor
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts/history/following', body.compact)
            break if data['data'].empty?

            body['cursor'] = data['data'].last['cursor']
            data['data'].each do |e|
              yielder.yield e
            end
          end
        end
      end

      # Grouped Alerts Enumerator of an organization by loading them, transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertRules)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_ids [Array<UUID>] Optional list of scan target IDs to list alerts from, defaults to all
      # @param states [Array<'OPEN', 'ACTIVE', 'IN_PROGRESS', 'RISK_ACCEPTED', 'CLOSED'>] Optional list of states to
      #   filter returned alerts, defaults to all
      # @param severities [Array<'CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'INFO'>] optional list of severities to filter
      #   returned alerts, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      #
      # @return an Grouped Alerts Enumerator object
      def iter_grouped_alerts(organization_id,
                              scan_target_ids: [],
                              states: nil,
                              severities: nil,
                              page_size: 100)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'scanTargetIds' => scan_target_ids.each { |scan_target_id| validate_uuid(scan_target_id) },
          'states' => states,
          'severities' => severities
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts/rules', body.compact)
            data['data'].each do |e|
              yielder.yield e
            end
            break if body['page'] == (data['total'] / body['pageSize']).ceil
          end
        end
      end

      # Grouped Alerts Following Enumerator of an organization by loading them, transparently paginating on the API
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertRulesFollowing)
      #
      # @param organization_id [UUID] of the organization
      # @param following_ids [Array<UUID>] Optional list of IDs of organizations you are following to
      #   list alerts from, defaults to all
      # @param states [Array<'OPEN', 'ACTIVE', 'IN_PROGRESS', 'RISK_ACCEPTED', 'CLOSED'>] Optional list of states to
      #   filter returned alerts, defaults to all
      # @param severities [Array<'CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'INFO'>] optional list of severities to filter
      #   returned alerts, defaults to all
      # @param page_size [Integer] the number of alerts to load from the API at a time
      #
      # @return an Grouped Alerts Following Enumerator object
      def iter_grouped_following_alerts(organization_id,
                                        following_ids: [],
                                        states: nil,
                                        severities: nil,
                                        page_size: 100)
        body = {
          'organizationId' => validate_uuid(organization_id),
          'page' => 0,
          'pageSize' => page_size,
          'followingIds' => following_ids.each { |following_id| validate_uuid(following_id) },
          'states' => states,
          'severities' => severities
        }

        Enumerator.new do |yielder|
          loop do
            body['page'] += 1
            data = @http.request('POST', '/alerts/rules/following', body.compact)
            data['data'].each do |e|
              yielder.yield e
            end
            break if body['page'] == (data['total'] / body['pageSize']).ceil
          end
        end
      end

      # Returns the detailed object that describes an alert
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/getAlertById)
      #
      # @param alert_id [UUID] of the alert
      #
      # @return a Object representing the alert
      def get_alert(alert_id)
        @http.request('GET', "/alerts/#{validate_uuid(alert_id)}")
      end

      # Alert History Enumerator over the history of an alert
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertHistory)
      #
      # @param alert_id [UUID] of the alert
      #
      # @return an Alert History Enumerator object
      def iter_alert_history(alert_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/alerts/#{validate_uuid(alert_id)}/history").each do |e|
            yielder.yield e
          end
        end
      end

      # Alert Comments Enumerator over the comment of an alert
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertComments)
      #
      # @param alert_id [UUID] of the alert
      #
      # @return an Alert Comments Enumerator object
      def iter_alert_comments(alert_id)
        Enumerator.new do |yielder|
          @http.request('GET', "/alerts/#{validate_uuid(alert_id)}/comments").each do |e|
            yielder.yield e
          end
        end
      end

      # Update alert
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/editOrganizationScanTargetAlertById)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      # @param alert_id [UUID] of the alert
      # @param state ['OPEN', 'ACTIVE', 'IN_PROGRESS', 'RISK_ACCEPTED']
      # @param labels [Array<String>] Optional labels to alert
      # @param comment [String] Accepted and required only when change :state to 'IN_PROGRESS'
      #
      # @return a Object representing the alert updated
      def update_alert(organization_id, scan_target_id, alert_id, state = nil, labels = nil, comment = nil)
        body = {
          'state' => state,
          'labels' => labels,
          'comment' => comment
        }

        @http.request(
          'PUT',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{
            validate_uuid(scan_target_id)}/alerts/#{validate_uuid(alert_id)}",
          body.compact
        )
      end

      # Create comment in alert
      # [#reference](https://api.zanshin.tenchisecurity.com/#operation/listAllAlertComments)
      #
      # @param organization_id [UUID] of the organization
      # @param scan_target_id [UUID] of the scan target
      # @param alert_id [UUID] of the alert
      # @param comment [String] in HTML format
      #
      # @return a Object representing the alert comment
      def create_alert_comment(organization_id, scan_target_id, alert_id, comment)
        body = {
          'comment' => comment
        }

        @http.request(
          'POST',
          "/organizations/#{validate_uuid(organization_id)}/scantargets/#{
            validate_uuid(scan_target_id)}/alerts/#{validate_uuid(alert_id)}/comments",
          body.compact
        )
      end
    end
  end
end
