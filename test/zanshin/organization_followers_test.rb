# frozen_string_literal: true

require_relative '../test_helper'

class OrganizationFollowersTest < ZanshinSDKTest
  ###################################################
  # Organization Follower
  ###################################################

  def test_iter_organization_followers
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/followers"])
    @zanshin.iter_organization_followers(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_stop_organization_follower
    @zanshin.http.expect(:request, nil, ['DELETE', "/organizations/#{TEST_UUID_A}/followers/#{TEST_UUID_B}"])
    @zanshin.stop_organization_follower(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  ###################################################
  # Organization Follower Request
  ###################################################

  def test_iter_organization_follower_requests
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/followers/requests"])
    @zanshin.iter_organization_follower_requests(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_create_organization_follower_request
    body = {
      'token' => TEST_UUID_B
    }
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/followers/requests", body])
    @zanshin.create_organization_follower_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_get_organization_follower_request
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}/followers/requests/#{TEST_UUID_B}"])
    @zanshin.get_organization_follower_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_delete_organization_follower_request
    @zanshin.http.expect(:request, nil, ['DELETE', "/organizations/#{TEST_UUID_A}/followers/requests/#{TEST_UUID_B}"])
    @zanshin.delete_organization_follower_request(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end
end
