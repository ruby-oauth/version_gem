# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [1.1.13] - 2026-06-22

- TAG: [v1.1.13][1.1.13t]
- COVERAGE: 48.74% -- 58/119 lines in 8 files
- BRANCH COVERAGE: 0.00% -- 0/4 branches in 8 files
- 85.19% documented

### Added

- Added support for JRuby 10.1 and TruffleRuby 34.0.

### Changed

- Retemplated project metadata and CI/development automation with `kettle-jem` v7.0.0.

### Fixed

- Corrected RubyGems homepage metadata to point at the gem documentation site.
- Corrected persisted Open Collective metadata to use the `ruby-oauth`
  collective.

- Updated the SimpleCov bootstrap so `.simplecov` remains configuration-only
  and coverage starts before the test harness can load `version_gem`.

## [1.1.12] - 2026-06-14

- TAG: [v1.1.12][1.1.12t]
- COVERAGE: 100.00% -- 58/58 lines in 2 files
- BRANCH COVERAGE: 0.00% -- 0/0 branches in 2 files
- 85.19% documented

### Changed

- Retemplated repository metadata, workflows, modular gemfiles, and documentation
  scaffolding with the current `kettle-jem` template.

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.
- Corrected misspelled contact metadata to use `galtzo.com`.

## [1.1.11] - 2026-06-06

- TAG: [v1.1.11][1.1.11t]
- COVERAGE: 100.00% -- 58/58 lines in 2 files
- BRANCH COVERAGE: 0.00% -- 0/0 branches in 2 files
- 85.19% documented

### Added

- Added the generated `appraisal2` binstub.

### Changed

- Refreshed generated CI workflows, README support badges, gemspec development
  dependency floors, and template metadata from the current kettle-jem
  template.
- Updated generated Appraisal2 integration to use the `appraisal2-rubocop`
  plugin DSL and raised the generated `appraisal2` / `appraisal2-rubocop`
  dependency floors.

## [1.1.10] - 2026-06-02

- TAG: [v1.1.10][1.1.10t]
- COVERAGE: 100.00% -- 58/58 lines in 2 files
- BRANCH COVERAGE: 0.00% -- 0/0 branches in 2 files
- 85.19% documented

### Added

- StructuredMerge-managed template configuration under `.structuredmerge/`,
  including semantic Git diff driver settings and kettle-drift integration.
- `rubocop-gradual` baseline tracking for style checks.

### Changed

- Re-templated the project with the current kettle-jem / StructuredMerge
  template.
- Development and test dependency floors now use current template floors:
  `kettle-dev` 2.0.7, `kettle-test` 2.0.3, `kettle-soup-cover` 2.0.0,
  `turbo_tests2` 3.1.1, `rubocop-lts` 8.3.0, and
  `rubocop-lts-rspec` 1.0.3.
- Development and test tooling now targets Ruby 2.4 or newer while the
  published runtime Ruby requirement remains Ruby 2.2 or newer.
- RSpec setup now loads `kettle-test` helpers and kettle-soup-cover coverage
  bootstrap from `spec/spec_helper.rb`.
- Templating dependencies now load only when `K_JEM_TEMPLATING=true`, with
  local StructuredMerge and Kettle workspace dependencies wired through
  `SMORG_RB_DEV`, `KETTLE_RB_DEV`, and `nomono`.
- Gem metadata and packaging inventory were refreshed by the template,
  including homepage, wiki, license-file, and packaged file handling.

### Removed

- Removed the obsolete `.yard_gfm_support.rb` documentation hook; YARD setup now
  uses the current template-managed plugin configuration.
- Removed obsolete CI workflows for Ruby 2.3, JRuby 9.1, TruffleRuby 23.2,
  CodeQL, framework CI, and Discord notifications.
- Removed legacy generated binstubs in favor of the current curated
  `kettle-check-eof`, `kettle-test`, and retained documentation binstubs.

### Fixed

- logo at top of README.md

- Fixed the Style workflow RBS validation command so CI uses the bundled `rbs`
  executable instead of the non-executable `bin/rbs` binstub.
- Fixed the Coverage workflow so Codecov repository-registration/upload errors
  do not fail CI after local coverage reports have already been generated and
  verified.

## [1.1.9] - 2025-09-02

- TAG: [v1.1.9][1.1.9t]
- COVERAGE: 100.00% -- 118/118 lines in 8 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 8 files
- 84.62% documented

### Added

- re-templated gem using kettle-dev v1.1.2
  - new binstubs for changelog, readme, commit message, & release management
  - new CI workflows
  - enhanced project documentation
- More RBS types
- docs site: https://version-gem.galtzo.com

### Fixed

- RBS types are more accurate

## [1.1.8] 2025-05-06

- TAG: [1.1.8][1.1.8t]
- COVERAGE: 100.00% -- 118/118 lines in 8 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 8 files
- 84.62% documented

### Added

- CITATION.cff (@pboling)
- Cryptographically signed with new 20-year cert (@pboling)
  - expires 2045-04-29
- Improved documentation (@pboling)
- Addressed entire REEK list (@pboling)
- GitLab CI, as an addition to existing GHA (@pboling)

## [1.1.7] 2025-04-15

- TAG: [1.1.7][1.1.7t]
- Line Coverage: 100.0% (117 / 117)
- Branch Coverage: 100.0% (4 / 4)
- 76.92% documented

### Added

- Support for Epoch Semantic Versioning (@pboling)
  - `extend VersionGem::Epoch` in your library's `MyLib::Version` module
- Support for JRuby 10 (@pboling)
- More documentation (@pboling)

### Removed

- Ruby 2.2 removed from CI, though technically still supported
  - can't run directly in GHA anymore

## [1.1.6] 2025-02-24

- TAG: [1.1.6][1.1.6t]
- Line Coverage: 100.0% (77 / 77)
- Branch Coverage: 100.0% (2 / 2)
- 77.78% documented

### Added

- Support for JRuby 9.1, 9.2, 9.3, 9.4, and head (@pboling)
- Support for Truffle Ruby 22.3, 23.0, 23.1, 24.1, and head (@pboling)
- Evergreen current latest engine release workflow (@pboling)
  - Runs ruby, truffleruby, and jruby, always latest release
- Improved developer experience for contributors (@pboling)
- More documentation (@pboling)
- Switch to stone_checksums for checksum generation (@pboling)

### Changed

- Code of Conduct updated - Contributor Covenant v2.0 => v2.1 (@pboling)

## [1.1.5] 2025-02-22

- TAG: [1.1.5][1.1.5t]
- Line Coverage: 100.0% (77 / 77)
- Branch Coverage: 100.0% (2 / 2)
- 77.78% documented

### Added

- Document approach to get code coverage on your gem's version.rb file (@pboling)
- More documentation, and yard task for documentation (@pboling)
- Documentation of Ruby version and SemVer support (@pboling)

### Fixed

- [#3](https://gitlab.com/ruby-oauth/version_gem/-/issues/3) - Allow packaging without signing (@pboling)
  - to support secure linux distros which have alternate means of signing packages within their package managers
- Code coverage tracking (@pboling)
- Documentation of usage in gemspec via `Kernel.load` (@pboling)
- Improved gemspec config (@pboling)

## [1.1.4] 2024-03-21

- TAG: [1.1.4][1.1.4t]

### Added

- Ruby 3.3 to CI (@pboling)

### Fixed

- Remove the executable bit from non-executable files (@Fryguy)

## [1.1.3] 2023-06-05

- TAG: [1.1.3][1.1.3t]

### Added

- More test coverage (now 100% 🎉) (@pboling)
- Improved documentation (now 77% 🎉) (@pboling)
- Gemfile context pattern (@pboling)
- Improved linting (via rubocop-lts) (@pboling)
- More robust GHA config (@pboling)
- (dev) Dependencies (@pboling)
  - yard-junk
  - redcarpet
  - pry, IRB alternative
  - pry-suite
  - debase,  for IDE debugging
- (dev) Rake task for rubocop_gradual (@pboling)

### Fixed

- (dev) `yard` documentation task (@pboling)

### Removed

- Formally drop Ruby 2.2 support
  - Ruby 2.2 was already de facto minimum version supported, which is why this wasn't a 2.0 release.

## [1.1.2] - 2023-03-17

- TAG: [1.1.2][1.1.2t]

### Added

- `VersionGem::Ruby` to help library CI integration against many different versions of Ruby (@pboling)
  - Experimental, optional, require (not loaded by default, which is why this can be in a patch)
- Spec coverage is now 100%, lines and branches, including the fabled `version.rb` (@pboling)
- Full RBS Signatures (@pboling)

## [1.1.1] - 2022-09-19

- TAG: [1.1.1][1.1.1t]

### Added

- Alternatives section to README.md (@pboling)
- Signing cert for gem releases (@pboling)
- Mailing List and other metadata URIs (@pboling)
- Checksums for released gems (@pboling)

### Changed

- SECURITY.md policy (@pboling)
- Version methods are now memoized (||=) on initial call for performance (@pboling)
- Gem releases are now cryptographically signed (@pboling)

## [1.1.0] - 2022-06-24

- TAG: [1.1.0][1.1.0t]

### Added

- RSpec Matchers and Shared Example (@pboling)

### Fixed

- `to_a` uses same type casting as major, minor, patch, and pre (@pboling)

## [1.0.2] - 2022-06-23

- TAG: [1.0.2][1.0.2t]

### Added

- Delay loading of library code until after code coverage tool is loaded (@pboling)

## [1.0.1] - 2022-06-23

- TAG: [1.0.1][1.0.1t]

### Added

- CI Build improvements (@pboling)
- Code coverage reporting (@pboling)
- Documentation improvements (@pboling)
- Badges! (@pboling)

## [1.0.0] - 2022-06-21

- TAG: [1.0.0][1.0.0t]

### Added

- Initial release, with basic version parsing API (@pboling)

[Unreleased]: https://github.com/ruby-oauth/version_gem/compare/v1.1.13...HEAD
[1.1.13]: https://github.com/ruby-oauth/version_gem/compare/v1.1.12...v1.1.13
[1.1.13t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.13
[1.1.12]: https://github.com/ruby-oauth/version_gem/compare/v1.1.11...v1.1.12
[1.1.12t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.12
[1.1.11]: https://github.com/ruby-oauth/version_gem/compare/v1.1.10...v1.1.11
[1.1.11t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.11
[1.1.10]: https://github.com/ruby-oauth/version_gem/compare/v1.1.9...v1.1.10
[1.1.10t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.10
[1.1.9]: https://github.com/ruby-oauth/version_gem/compare/v1.1.8...v1.1.9
[1.1.9t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.9
[1.1.8]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.7...v1.1.8
[1.1.8t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.8
[1.1.7]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.6...v1.1.7
[1.1.7t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.7
[1.1.6]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.5...v1.1.6
[1.1.6t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.6
[1.1.5]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.4...v1.1.5
[1.1.5t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.5
[1.1.4]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.3...v1.1.4
[1.1.4t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.4
[1.1.3]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.2...v1.1.3
[1.1.3t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.3
[1.1.2]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.1...v1.1.2
[1.1.2t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.2
[1.1.1]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.1.0...v1.1.1
[1.1.1t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.1
[1.1.0]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.0.2...v1.1.0
[1.1.0t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.1.0
[1.0.2]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.0.1...v1.0.2
[1.0.2t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.0.2
[1.0.1]: https://gitlab.com/ruby-oauth/version_gem/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.0.1
[1.0.0]: https://github.com/ruby-oauth/version_gem/compare/a3055964517c159bf214712940982034b75264be...v1.0.0
[1.0.0t]: https://github.com/ruby-oauth/version_gem/releases/tag/v1.0.0
