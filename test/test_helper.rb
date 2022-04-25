# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

require 'bundler/setup'
require 'minitest/autorun'

require 'zanshin'
require 'configparser'

class ZanshinSDKTest < Minitest::Test
  TEST_UUID_A = '00000000-ffff-4000-a000-000000000001'
  TEST_UUID_B = '00000000-ffff-4000-a000-000000000002'
  TEST_UUID_C = '00000000-ffff-4000-a000-000000000003'

  def setup
    File.stub(:exist?, true) do
      ConfigParser.stub(:new, {
                          'default' => {
                            'api_key' => 'test_key'
                          }
                        }) do
        @zanshin = Zanshin::SDK::Client.new
        @zanshin.http = Minitest::Mock.new
      end
    end
  end
end
