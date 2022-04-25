# frozen_string_literal: true

require_relative '../../test_helper'

class ZanshinRequestTest < Minitest::Test
  def setup
    @http = Zanshin::SDK::Request::HTTPClient.new('api_key', 'https://test.com', 'TestSDK', nil)
    @http.http_client = Minitest::Mock.new
  end

  def test_request
    response = Object.new
    response.singleton_class.define_method(:code) do
      200
    end
    response.singleton_class.define_method(:body) do
      '{}'
    end

    @http.http_client.expect(:send_request, response, ['GET', '/path', nil, @http.headers])
    @http.request('GET', '/path')
    assert @http.http_client.verify
  end
end
