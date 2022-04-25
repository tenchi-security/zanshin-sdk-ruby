# frozen_string_literal: true

require_relative '../test_helper'

class SummariesTest < ZanshinSDKTest
  ###################################################
  # Summaries
  ###################################################

  def test_get_alert_summaries
    body = {
      'organizationId' => TEST_UUID_A,
      'scanTargetIds' => [TEST_UUID_B, TEST_UUID_C]
    }

    @zanshin.http.expect(:request, nil, ['POST', '/alerts/summaries', body])
    @zanshin.get_alert_summaries(TEST_UUID_A, [TEST_UUID_B, TEST_UUID_C])
    assert @zanshin.http.verify
  end

  def test_get_following_alert_summaries
    body = {
      'organizationId' => TEST_UUID_A,
      'followingIds' => [TEST_UUID_B, TEST_UUID_C]
    }

    @zanshin.http.expect(:request, nil, ['POST', '/alerts/summaries/following', body])
    @zanshin.get_following_alert_summaries(TEST_UUID_A, [TEST_UUID_B, TEST_UUID_C])
    assert @zanshin.http.verify
  end

  def test_get_scan_summaries
    body = {
      'organizationId' => TEST_UUID_A,
      'scanTargetIds' => [TEST_UUID_B, TEST_UUID_C],
      'daysBefore' => 5
    }

    @zanshin.http.expect(:request, nil, ['POST', '/alerts/summaries/scans', body])
    @zanshin.get_scan_summaries(TEST_UUID_A, [TEST_UUID_B, TEST_UUID_C], 5)
    assert @zanshin.http.verify
  end

  def test_get_following_scan_summaries
    body = {
      'organizationId' => TEST_UUID_A,
      'followingIds' => [TEST_UUID_B, TEST_UUID_C],
      'daysBefore' => 5
    }

    @zanshin.http.expect(:request, nil, ['POST', '/alerts/summaries/scans/following', body])
    @zanshin.get_following_scan_summaries(TEST_UUID_A, [TEST_UUID_B, TEST_UUID_C], 5)
    assert @zanshin.http.verify
  end
end
