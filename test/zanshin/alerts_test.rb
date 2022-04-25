# frozen_string_literal: true

require_relative '../test_helper'

class AlertsTest < ZanshinSDKTest
  ###################################################
  # Alerts
  ###################################################

  def test_iter_alerts
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'scanTargetIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_alerts(TEST_UUID_A,
                                  scan_target_ids: [TEST_UUID_B, TEST_UUID_C],
                                  page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_iter_following_alerts
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'followingIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_following_alerts(TEST_UUID_A,
                                            following_ids: [TEST_UUID_B, TEST_UUID_C],
                                            page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/following', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/following', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_iter_alerts_history
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'scanTargetIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_alerts_history(TEST_UUID_A,
                                          scan_target_ids: [TEST_UUID_B, TEST_UUID_C],
                                          page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/history', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/history', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_iter_alerts_following_history
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'followingIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_alerts_following_history(TEST_UUID_A,
                                                    following_ids: [TEST_UUID_B, TEST_UUID_C],
                                                    page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/history/following', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/history/following', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_iter_grouped_alerts
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'scanTargetIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_grouped_alerts(TEST_UUID_A,
                                          scan_target_ids: [TEST_UUID_B, TEST_UUID_C],
                                          page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/rules', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/rules', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_iter_grouped_following_alerts
    body = {
      'organizationId' => TEST_UUID_A, 'page' => 1, 'pageSize' => 1, 'followingIds' => [TEST_UUID_B, TEST_UUID_C]
    }
    alerts = @zanshin.iter_grouped_following_alerts(TEST_UUID_A,
                                                    following_ids: [TEST_UUID_B, TEST_UUID_C],
                                                    page_size: 1)

    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/rules/following', body])
    alerts.next
    assert @zanshin.http.verify
    body['page'] = 2
    @zanshin.http.expect(:request, { 'data' => [''], 'total' => 2 }, ['POST', '/alerts/rules/following', body])
    alerts.next
    assert @zanshin.http.verify
  end

  def test_get_alert
    @zanshin.http.expect(:request, nil, ['GET', "/alerts/#{TEST_UUID_A}"])
    @zanshin.get_alert(TEST_UUID_A)
    assert @zanshin.http.verify
  end

  def test_iter_alert_history
    @zanshin.http.expect(:request, [''], ['GET', "/alerts/#{TEST_UUID_A}/history"])
    @zanshin.iter_alert_history(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_iter_alert_comments
    @zanshin.http.expect(:request, [''], ['GET', "/alerts/#{TEST_UUID_A}/comments"])
    @zanshin.iter_alert_comments(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_update_alert
    body = {
      'state' => 'OPEN',
      'labels' => [],
      'comment' => '<p>comment</p>'
    }

    @zanshin.http.expect(:request, nil, ['PUT', "/organizations/#{TEST_UUID_A}/scantargets/#{
                                          TEST_UUID_B}/alerts/#{TEST_UUID_C}", body])
    @zanshin.update_alert(TEST_UUID_A, TEST_UUID_B, TEST_UUID_C, 'OPEN', [], '<p>comment</p>')
    assert @zanshin.http.verify
  end

  def test_create_alert_comment
    body = {
      'comment' => '<p>comment</p>'
    }

    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/scantargets/#{
      TEST_UUID_B}/alerts/#{TEST_UUID_C}/comments", body])
    @zanshin.create_alert_comment(TEST_UUID_A, TEST_UUID_B, TEST_UUID_C, '<p>comment</p>')
    assert @zanshin.http.verify
  end
end
