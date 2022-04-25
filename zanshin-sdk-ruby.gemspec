# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zanshin/version'

Gem::Specification.new do |spec|
  spec.name        = 'zanshin'
  spec.version     = Zanshin::SDK::VERSION
  spec.authors     = ['Tenchi Security']
  spec.email       = ['contact@tenchisecurity.com']
  spec.summary     = 'Zanshin SDK'
  spec.description = 'Ruby SDK to access the Tenchi Security Zanshin API v1'
  spec.homepage    = 'https://tenchisecurity.com'
  spec.license     = 'MIT'

  spec.metadata['source_code_uri'] = 'https://github.com/tenchi-security/zanshin-sdk-ruby'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['documentation_uri'] = 'https://www.rubydoc.info/gems/zanshin'

  spec.required_ruby_version = '>= 2.6'
  spec.require_paths = ['lib']
  spec.files = %w[README.md
                  LICENSE.md
                  lib/zanshin.rb
                  lib/zanshin/request/zanshin_request.rb
                  lib/zanshin/request/zanshin_request_error.rb
                  lib/zanshin/account.rb
                  lib/zanshin/alerts.rb
                  lib/zanshin/client.rb
                  lib/zanshin/organization_followers.rb
                  lib/zanshin/organization_following.rb
                  lib/zanshin/organization_members.rb
                  lib/zanshin/organization_scan_targets.rb
                  lib/zanshin/organizations.rb
                  lib/zanshin/scan_target.rb
                  lib/zanshin/summaries.rb
                  lib/zanshin/version.rb]

  spec.add_dependency 'configparser', '~> 0.1.7'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'redcarpet', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 1.27'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.19.1'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
  spec.add_development_dependency 'yard', '~> 0.9.27'
end
