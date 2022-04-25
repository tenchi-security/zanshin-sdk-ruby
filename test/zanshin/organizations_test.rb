# frozen_string_literal: true

require_relative '../test_helper'

class OrganizationTest < ZanshinSDKTest
  ###################################################
  # Organizations
  ###################################################

  def test_iter_organization_members_invites
    @zanshin.http.expect(:request, [''], %w[GET /organizations])
    @zanshin.iter_organizations.to_a
    assert @zanshin.http.verify
  end

  def test_get_organization
    @zanshin.http.expect(:request, nil, ['GET', "/organizations/#{TEST_UUID_A}"])
    @zanshin.get_organization(TEST_UUID_A)
    assert @zanshin.http.verify
  end

  def test_update_organization
    body = {
      'name' => 'name',
      'picture' => 'picture',
      'email' => 'email'
    }

    @zanshin.http.expect(:request, nil, ['PUT', "/organizations/#{TEST_UUID_A}", body])
    @zanshin.update_organization(TEST_UUID_A, name: 'name', picture: 'picture', email: 'email')
    assert @zanshin.http.verify
  end
end
