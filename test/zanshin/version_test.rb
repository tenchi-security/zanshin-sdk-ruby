# frozen_string_literal: true

require_relative '../test_helper'

class VersionTest < Minitest::Test
  def test_version
    refute_nil ::Zanshin::SDK::VERSION
  end
end
