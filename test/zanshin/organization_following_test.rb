# frozen_string_literal: true

require_relative '../test_helper'

class OrganizationFollowingTest < ZanshinSDKTest
  ###################################################
  # Organization Following
  ###################################################

  def test_iter_organization_following
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/following"])
    @zanshin.iter_organization_following(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_stop_organization_following
    @zanshin.http.expect(:request, true, ['DELETE', "/organizations/#{TEST_UUID_A}/following/#{TEST_UUID_B}"])
    @zanshin.stop_organization_following(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  ###################################################
  # Organization Following Request
  ###################################################

  def test_iter_organization_following_requests
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/following/requests"])
    @zanshin.iter_organization_following_requests(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_get_organization_following_request
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}/following/requests/#{TEST_UUID_B}"])
    @zanshin.get_organization_following_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_accept_organization_following_request
    @zanshin.http.expect(:request, nil, ['POST',
                                         "/organizations/#{TEST_UUID_A}/following/requests/#{TEST_UUID_B}/accept"])
    @zanshin.accept_organization_following_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_decline_organization_following_request
    @zanshin.http.expect(:request, nil, ['POST',
                                         "/organizations/#{TEST_UUID_A}/following/requests/#{TEST_UUID_B}/decline"])
    @zanshin.decline_organization_following_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end
end
