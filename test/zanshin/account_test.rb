# frozen_string_literal: true

require_relative '../test_helper'

class AccountTest < ZanshinSDKTest
  ###################################################
  # Account
  ###################################################

  def test_get_me
    @zanshin.http.expect(:request, nil, %w[GET /me])
    @zanshin.get_me
    assert @zanshin.http.verify
  end

  ###################################################
  # Account Invites
  ###################################################

  def test_iter_invites
    @zanshin.http.expect(:request, [''], %w[GET /me/invites])
    @zanshin.iter_invites.to_a
    assert @zanshin.http.verify
  end

  def test_get_invite
    @zanshin.http.expect(:request, nil, ['GET', "/me/invites/#{TEST_UUID_A}"])
    @zanshin.get_invite(TEST_UUID_A)
    assert @zanshin.http.verify
  end

  def test_accept_invite
    @zanshin.http.expect(:request, nil, ['POST', "/me/invites/#{TEST_UUID_A}/accept"])
    @zanshin.accept_invite(TEST_UUID_A)
    assert @zanshin.http.verify
  end

  ###################################################
  # Account API key
  ###################################################
  def test_iter_api_keys
    @zanshin.http.expect(:request, [''], %w[GET /me/apikeys])
    @zanshin.iter_api_keys.to_a
    assert @zanshin.http.verify
  end

  def test_create_api_key
    body = {}
    body['name'] = 'name'
    @zanshin.http.expect(:request, nil, ['POST', '/me/apikeys', body])
    @zanshin.create_api_key('name')
    assert @zanshin.http.verify
  end

  def test_delete_api_key
    @zanshin.http.expect(:request, nil, ['DELETE', "/me/apikeys/#{TEST_UUID_A}"])
    @zanshin.delete_api_key(TEST_UUID_A)
    assert @zanshin.http.verify
  end
end
