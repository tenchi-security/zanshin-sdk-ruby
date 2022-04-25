# frozen_string_literal: true

require_relative '../test_helper'

class OrganizationScanTargetsTest < ZanshinSDKTest
  ###################################################
  # Organization Scan Targets
  ###################################################

  def test_iter_organization_scan_targets
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/scantargets"])
    @zanshin.iter_organization_scan_targets(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_create_organization_scan_target
    body = {
      'kind' => 'AWS', 'name' => 'name',
      'credential' => {
        'account' => 'AWSTest'
      }, 'schedule' => 'cron'
    }
    aws = Zanshin::SDK::ScanTarget::AWS.new('AWSTest')

    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/scantargets", body])
    @zanshin.create_organization_scan_target(TEST_UUID_A, 'name', aws, 'cron')
    assert @zanshin.http.verify
  end

  def test_create_organization_scan_target_invalid
    error = assert_raises do
      @zanshin.create_organization_scan_target(TEST_UUID_A, 'name', 'invalid', 'cron')
    end
    assert_equal('String is invalid instance of Zanshin::SDK::ScanTarget classes', error.message)
  end

  def test_get_organization_scan_target
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}"])
    @zanshin.get_organization_scan_target(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_update_organization_scan_target
    body = {
      'name' => 'name',
      'schedule' => 'cron'
    }

    @zanshin.http.expect(:request, nil, ['PUT', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}", body])
    @zanshin.update_organization_scan_target(TEST_UUID_A, TEST_UUID_B, 'name', 'cron')
    assert @zanshin.http.verify
  end

  def test_delete_organization_scan_target
    @zanshin.http.expect(:request, nil, ['DELETE', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}"])
    @zanshin.delete_organization_scan_target(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_start_organization_scan_target_scan
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}/scan"])
    @zanshin.start_organization_scan_target_scan(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_stop_organization_scan_target_scan
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}/stop"])
    @zanshin.stop_organization_scan_target_scan(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_check_organization_scan_target
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}/check"])
    @zanshin.check_organization_scan_target(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  ###################################################
  # Organization Scan Target Scan
  ###################################################

  def test_iter_organization_scan_target_scans
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}/scans"])
    @zanshin.iter_organization_scan_target_scans(TEST_UUID_A, TEST_UUID_B).to_a
    assert @zanshin.http.verify
  end

  def test_get_organization_scan_target_scan
    @zanshin.http.expect(:request, nil, [
                           'GET',
                           "/organizations/#{TEST_UUID_A}/scantargets/#{TEST_UUID_B}/scans/#{TEST_UUID_C}"
                         ])
    @zanshin.get_organization_scan_target_scan(TEST_UUID_A, TEST_UUID_B, TEST_UUID_C)
    assert @zanshin.http.verify
  end
end
