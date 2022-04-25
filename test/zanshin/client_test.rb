# frozen_string_literal: true

require_relative '../test_helper'

class ClientTest < ZanshinSDKTest
  ###################################################
  # initialize
  ###################################################

  def test_initialize_wrong_profile
    File.stub(:exist?, true) do
      ConfigParser.stub(:new, {
                          'default' => {
                            'api_key' => 'test_key'
                          }
                        }) do
        error = assert_raises { Zanshin::SDK::Client.new(profile: 'invalid') }
        assert_equal("Profile invalid not found in #{Zanshin::SDK::CONFIG_FILE}", error.message)
      end
    end
  end

  def test_initialize_not_found
    File.stub(:exist?, false) do
      error = assert_raises { Zanshin::SDK::Client.new }
      assert_equal("Not found #{Zanshin::SDK::CONFIG_FILE}", error.message)
    end
  end

  ###################################################
  # Properties
  ###################################################

  def test_set_api_key
    api_key = 'test_key'
    @zanshin.api_key = api_key
    assert_equal(api_key, @zanshin.api_key)
  end

  def test_set_api_key_nil
    error = assert_raises { @zanshin.api_key = nil }
    assert_equal('API key cannot be nil', error.message)
  end

  def test_set_api_url
    api_url = 'https://test.com'
    @zanshin.api_url = api_url
    assert_equal(api_url, @zanshin.api_url)
  end

  def test_set_api_url_invalid
    error = assert_raises { @zanshin.api_url = 'ws://test.com' }
    assert_equal('Invalid API URL: ws://test.com', error.message)
  end

  def test_set_api_url_nil
    error = assert_raises { @zanshin.api_url = nil }
    assert_equal('API URL cannot be nil', error.message)
  end

  def test_user_agent
    user_agent = 'Test'
    @zanshin.user_agent = user_agent
    assert_equal("#{user_agent}/Zanshin Ruby SDK #{Zanshin::SDK::VERSION}", @zanshin.user_agent)
  end

  def test_user_agent_nil
    @zanshin.user_agent = nil
    assert_equal("Zanshin Ruby SDK #{Zanshin::SDK::VERSION}", @zanshin.user_agent)
  end

  def test_user_agent_empty
    user_agent = ''
    @zanshin.user_agent = user_agent
    assert_equal("Zanshin Ruby SDK #{Zanshin::SDK::VERSION}", @zanshin.user_agent)
  end

  def test_user_agent_number
    user_agent = 123
    @zanshin.user_agent = user_agent
    assert_equal("#{user_agent}/Zanshin Ruby SDK #{Zanshin::SDK::VERSION}", @zanshin.user_agent)
  end

  def test_set_proxy_url_nil
    @zanshin.proxy_url = nil
    assert_nil(@zanshin.proxy_url)
  end

  def test_set_proxy_url_no_auth
    proxy_url = 'https://proxy.thing.com:8080/'
    @zanshin.proxy_url = proxy_url
    assert_equal(proxy_url, @zanshin.proxy_url)
  end

  def test_set_proxy_url
    proxy_url = 'https://username:password@proxy.thing.com:8080/'
    @zanshin.proxy_url = proxy_url
    assert_equal(proxy_url, @zanshin.proxy_url)
  end

  def test_set_proxy_url_no_password
    proxy_url = 'https://username@proxy.thing.com:8080/'
    error = assert_raises { @zanshin.proxy_url = proxy_url }
    assert_equal("Invalid proxy URL: #{proxy_url}", error.message)
  end

  ###################################################
  # Validate UUID
  ###################################################

  def test_validate_uuid
    invalid_uuid = 'InvalidUUID'
    error = assert_raises { @zanshin.get_invite(invalid_uuid) }
    assert_equal("#{invalid_uuid} is not a valid UUID", error.message)
  end
end
