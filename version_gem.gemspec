# frozen_string_literal: true

gem_version =
  if RUBY_VERSION >= "3.1"
    # Loading version into an anonymous module allows version.rb to get code coverage from SimpleCov!
    # See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
    Module.new.tap { |mod| Kernel.load("lib/version_gem/version.rb", mod) }::VersionGem::Version::VERSION
  else
    # TODO: Remove this hack once support for Ruby 3.0 and below is removed
    Kernel.load("lib/version_gem/version.rb")
    g_ver = VersionGem::Version::VERSION
    VersionGem::Version.send(:remove_const, :VERSION)
    g_ver
  end

Gem::Specification.new do |spec|
  # Linux distros may package ruby gems differently,
  #   and securely certify them independently via alternate package management systems.
  # Ref: https://gitlab.com/oauth-xx/version_gem/-/issues/3
  # Hence, only enable signing if `SKIP_GEM_SIGNING` is not set in ENV.
  # See CONTRIBUTING.md
  user_cert = "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem"
  cert_file_path = File.join(__dir__, user_cert)
  cert_chain = cert_file_path.split(",")
  cert_chain.select! { |fp| File.exist?(fp) }
  if cert_file_path && cert_chain.any?
    spec.cert_chain = cert_chain
    if $PROGRAM_NAME.end_with?("gem") && ARGV[0] == "build" && !ENV.include?("SKIP_GEM_SIGNING")
      spec.signing_key = File.join(Gem.user_home, ".ssh", "gem-private_key.pem")
    end
  end

  spec.name = "version_gem"
  spec.version = gem_version
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com", "oauth-ruby@googlegroups.com"]

  spec.summary = "🔖 Enhance your VERSION! Sugar for Version modules."
  spec.description = "🔖 Versions are good. Versions are cool. Versions will win."
  spec.homepage = "https://gitlab.com/oauth-xx/version_gem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.2"

  spec.metadata["homepage_uri"] = "https://railsbling.com/tags/#{spec.name}/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/-/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/-/wiki"
  spec.metadata["mailing_list_uri"] = "https://groups.google.com/g/oauth-ruby"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[
    # Files (alphabetical)
    "lib/**/*",
  ]
  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "README.md",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]
  spec.require_paths = ["lib"]

  spec.add_development_dependency("kettle-dev", "~> 1.0", ">= 1.0.25")    # ruby >= 2.3
end
