# frozen_string_literal: true

require_relative '../../test_helper'

class ZanshinRequestErrorTest < Minitest::Test
  def setup
    @http = Zanshin::SDK::Request::HTTPClient.new('api_key', 'https://test.com', 'TestSDK', nil)
    @http.http_client = Minitest::Mock.new
  end

  def test_request_error
    response = Object.new
    response.singleton_class.define_method(:code) do
      401
    end
    response.singleton_class.define_method(:body) do
      '{"message": "Unauthorized"}'
    end

    @http.http_client.expect(:send_request, response, ['GET', '/path', nil, @http.headers])
    error = assert_raises { @http.request('GET', '/path') }
    assert_equal('401 - Unauthorized', "#{error.code} - #{error.body}")
  end
end
