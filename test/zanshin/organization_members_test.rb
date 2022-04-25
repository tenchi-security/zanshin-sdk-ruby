# frozen_string_literal: true

require_relative '../test_helper'

class OrganizationMembersTest < ZanshinSDKTest
  ###################################################
  # Organization Member
  ###################################################

  def test_iter_organization_members
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/members"])
    @zanshin.iter_organization_members(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_get_organization_member
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}/members/#{TEST_UUID_B}"])
    @zanshin.get_organization_member(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_update_organization_member
    body = {
      'roles' => []
    }
    @zanshin.http.expect(:request, nil, ['PUT', "/organizations/#{TEST_UUID_A}/members/#{TEST_UUID_B}", body])
    @zanshin.update_organization_member(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_delete_organization_member
    @zanshin.http.expect(:request, nil, ['DELETE', "/organizations/#{TEST_UUID_A}/members/#{TEST_UUID_B}"])
    @zanshin.delete_organization_member(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_reset_organization_member_mfa
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/members/#{TEST_UUID_B}/mfa/reset"])
    @zanshin.reset_organization_member_mfa(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  def test_reset_organization_member_password
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/members/#{TEST_UUID_B}/password/reset"])
    @zanshin.reset_organization_member_password(TEST_UUID_A, TEST_UUID_B)
    assert @zanshin.http.verify
  end

  ###################################################
  # Organization Member Invite
  ###################################################

  def test_iter_organization_members_invites
    @zanshin.http.expect(:request, [''], ['GET', "/organizations/#{TEST_UUID_A}/invites"])
    @zanshin.iter_organization_members_invites(TEST_UUID_A).to_a
    assert @zanshin.http.verify
  end

  def test_create_organization_members_invite
    body = {
      'email' => 'email@test.com',
      'roles' => []
    }

    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/invites", body])
    @zanshin.create_organization_members_invite(TEST_UUID_A, 'email@test.com')
    assert @zanshin.http.verify
  end

  def test_get_organization_member_invite
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}/invites/email@test.com"])
    @zanshin.get_organization_member_invite(TEST_UUID_A, 'email@test.com')
    assert @zanshin.http.verify
  end

  def test_delete_organization_member_invite
    @zanshin.http.expect(:request, nil, ['DELETE', "/organizations/#{TEST_UUID_A}/invites/email@test.com"])
    @zanshin.delete_organization_member_invite(TEST_UUID_A, 'email@test.com')
    assert @zanshin.http.verify
  end

  def test_resend_organization_member_invite
    @zanshin.http.expect(:request, nil, ['POST', "/organizations/#{TEST_UUID_A}/invites/email@test.com/resend"])
    @zanshin.resend_organization_member_invite(TEST_UUID_A, 'email@test.com')
    assert @zanshin.http.verify
  end
end
