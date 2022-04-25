# frozen_string_literal: true

require_relative 'zanshin/client'
require_relative 'zanshin/version'

# {include:file:README.md}
module Zanshin
  # Zanshin SDK
  module SDK
    # The default endpoint for Zanshin API
    ZANSHIN_API = 'https://api.zanshin.tenchi-dev.com'
    # The directory that Zanshin uses to store/get private settings
    CONFIG_DIR = "#{Dir.home}/.tenchi"
    # The file that Zanshin uses to store/get private settings
    CONFIG_FILE = "#{CONFIG_DIR}/config"
  end
end
