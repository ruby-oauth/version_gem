# frozen_string_literal: true

RSpec.describe(VersionGem::Api) do
  context "when under test" do
    subject(:under_test) { UnderTest }

    it_behaves_like "a Version module", UnderTest

    it "is greater than 0.1.0" do
      expect(Gem::Version.new(under_test) > Gem::Version.new("0.1.0")).to(be(true))
    end

    it "major version is an integer" do
      expect(under_test.major).to(eq(12))
    end

    it "minor version is an integer" do
      expect(under_test.minor).to(eq(34))
    end

    it "patch version is an integer" do
      expect(under_test.patch).to(eq(56))
    end

    it "pre version is an string" do
      expect(under_test.pre).to(eq("pre-78"))
    end

    it "returns a Hash" do
      expect(under_test.to_h).to(eq(major: 12, minor: 34, patch: 56, pre: "pre-78"))
    end

    it "returns an Array" do
      expect(under_test.to_a).to(eq([12, 34, 56, "pre-78"]))
    end
  end

  context "when memoizing lookups" do
    let(:version_string) { "1.2.3.pre-78".dup }
    let(:version_module) do
      Module.new.tap do |mod|
        mod.const_set(:VERSION, version_string)
        mod.extend(described_class)
      end
    end

    it "splits the version string only once across component lookups" do
      expect(version_string).to(receive(:split).once.and_call_original)

      version_module.major
      version_module.minor
      version_module.patch
      version_module.pre
    end
  end
end
