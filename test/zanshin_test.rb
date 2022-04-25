# frozen_string_literal: true

require_relative 'test_helper'

class ZanshinTest < Minitest::Test
  def test_zanshin_api
    refute_nil ::Zanshin::SDK::ZANSHIN_API
  end

  def test_config_dir
    refute_nil ::Zanshin::SDK::CONFIG_DIR
  end

  def test_config_file
    refute_nil ::Zanshin::SDK::CONFIG_FILE
  end
end
