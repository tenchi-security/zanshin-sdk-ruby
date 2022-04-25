# frozen_string_literal: true

require_relative '../test_helper'

class ScanTargetTest < Minitest::Test
  ###################################################
  # KIND
  ###################################################

  def test_scan_target_aws_kind
    assert_equal('AWS', Zanshin::SDK::ScanTarget::AWS::KIND)
  end

  def test_scan_target_azure_kind
    assert_equal('Azure', Zanshin::SDK::ScanTarget::Azure::KIND)
  end

  def test_scan_target_gcp_kind
    assert_equal('GCP', Zanshin::SDK::ScanTarget::GCP::KIND)
  end

  def test_scan_target_huawei_kind
    assert_equal('HUAWEI', Zanshin::SDK::ScanTarget::HUAWEI::KIND)
  end

  def test_scan_target_domain_kind
    assert_equal('DOMAIN', Zanshin::SDK::ScanTarget::DOMAIN::KIND)
  end

  ###################################################
  # Output
  ###################################################

  def test_scan_target_aws_output
    data = {
      'account' => 'AWSAccount'
    }

    client = Zanshin::SDK::ScanTarget::AWS.new('AWSAccount')
    assert_equal(data, client.to_json)
  end

  def test_scan_target_azure_output
    data = {
      'application_id' => 'AzureApplicationID', 'subscription_id' => 'AzureSubscriptionID',
      'directory_id' => 'AzureDirectoryID', 'secret' => 'AzureSecret'
    }

    client = Zanshin::SDK::ScanTarget::Azure.new('AzureApplicationID',
                                                 'AzureSubscriptionID',
                                                 'AzureDirectoryID',
                                                 'AzureSecret')
    assert_equal(data, client.to_json)
  end

  def test_scan_target_gcp_output
    data = {
      'project_id' => 'GCPProjectID'
    }

    client = Zanshin::SDK::ScanTarget::GCP.new('GCPProjectID')
    assert_equal(data, client.to_json)
  end

  def test_scan_target_huawei_output
    data = {
      'account_id' => 'HUAWEIAccountID'
    }

    client = Zanshin::SDK::ScanTarget::HUAWEI.new('HUAWEIAccountID')
    assert_equal(data, client.to_json)
  end

  def test_scan_target_domain_output
    data = {
      'domain' => 'DOMAINTest'
    }

    client = Zanshin::SDK::ScanTarget::DOMAIN.new('DOMAINTest')
    assert_equal(data, client.to_json)
  end
end
