# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development and GitLab CI                     #
# Gemfile is NOT loaded in GitHub Actions CI                         #
####################################################### IMPORTANT ####

# For Ruby version specific dependencies
ruby_version = Gem::Version.create(RUBY_VERSION)

# Include dependencies from <gem name>.gemspec
gemspec

platform :mri do
  # Debugging - Ensure ENV["DEBUG"] == "true" to use debuggers within spec suite
  if ruby_version < Gem::Version.create("2.7")
    # Use byebug in code
    gem "byebug", ">= 11"
  else
    # Use binding.break, binding.b, or debugger in code
    gem "debug", ">= 1.0.0"
  end

  # Dev Console - Binding.pry - Irb replacement
  gem "pry", "~> 0.14"                     # ruby >= 2.0
end

# Security Audit
if ruby_version >= Gem::Version.create("3")
  # NOTE: Audit fails on Ruby 2.7 because nokogiri has dropped support for Ruby < 3
  # See: https://github.com/sparklemotion/nokogiri/security/advisories/GHSA-r95h-9x8f-r3f7
  # We can't add upgraded nokogiri here unless we are developing on Ruby 3+
  eval_gemfile "gemfiles/modular/audit.gemfile"
end

# Code Coverage
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"
