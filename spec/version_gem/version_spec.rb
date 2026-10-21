# frozen_string_literal: true

require "anonymous_loader"
require "version_gem"
RSpec.describe VersionGem::Version do
  it_behaves_like "a Version module", described_class

  it "executes the version file for coverage without redefining constants" do
    dir = File.expand_path("../../lib/version_gem", __dir__)
    paths = %w[version.rb version_gem.rb].map { |file| File.join(dir, file) }.select { |path| File.file?(path) }
    anonymous_namespace = AnonymousLoader.load(files: paths)

    expect(anonymous_namespace::VersionGem::Version::VERSION).to eq(described_class::VERSION)
  end
end
