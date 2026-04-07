# frozen_string_literal: true

# kettle-jem:freeze
# To retain chunks of comments & code during version_gem templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# version_gem will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

source "https://gem.coop"

git_source(:codeberg) { |repo_name| "https://codeberg.org/#{repo_name}" }

git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

# Include dependencies from version_gem.gemspec
gemspec

platform :mri do
end

# Code Coverage (env-switched: KETTLE_RB_DEV=true for local paths)
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

# Optional
eval_gemfile "gemfiles/modular/optional.gemfile"

### Std Lib Extracted Gems
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"

# See unlocked_deps appraisal for more details on irb inclusion
gem "irb", "~> 1.17" # ruby >= 2.7

# Templating (env-switched: KETTLE_RB_DEV=true for local paths)
eval_gemfile "gemfiles/modular/templating.gemfile"

# Debugging
eval_gemfile "gemfiles/modular/debug.gemfile"
