# frozen_string_literal: true

# Config for development dependencies of this library
# i.e., not configured by this library
#
# SimpleCov & related config (must run BEFORE any other requires)
# NOTE: Gemfiles for non-coverage appraisals may not have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message and re-raise when unexpected
  raise error unless error.message.include?("kettle")
end

# External RSpec & related config
require "kettle/test/rspec"

DEBUG = ENV.fetch("DEBUG", nil) == "true"
DEBUG_IDE = ENV.fetch("DEBUG_IDE", "false") == "true"

# RSpec Configs
require_relative "config/byebug"
require_relative "config/rspec/rspec_core"
require_relative "config/rspec/rspec_block_is_expected"

# RSpec Helpers which do not depend on gem internals
require_relative "helpers/faux"

# Last thing before this gem is code coverage:
begin
  # kettle-soup-cover does not require "simplecov", but
  #   we do that next, and that has a side effect of running `.simplecov`
  # Also, we must avoid loading "version_gem" (this gem) via "kettle-soup-cover",
  #   so instead of the normal kettle-soup-cover, or kettle/soup/cover,
  #   we do some proper hacking around the internals. Fortunately 2 gems, one author!
  # require "kettle/soup/cover"
  require "kettle/change"
  require "kettle/soup/cover/version"
  require "kettle/soup/cover/loaders"
  require "kettle/soup/cover/constants"
  require "simplecov" if Kettle::Soup::Cover::Constants::DO_COV
rescue LoadError
  nil
end

# This gem
require "version_gem"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
# RSpec Helpers from this gem
require "version_gem/rspec"

# RSpec Helpers which depend on gem internals
require_relative "helpers/under_test"
require_relative "helpers/epoch_test"
