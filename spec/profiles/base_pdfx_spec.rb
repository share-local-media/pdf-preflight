require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Profiles::BasePDFX do
  let(:filename)  { pdf_spec_file(file_string) }
  let(:preflight) { Preflight::Profiles::BasePDFX.new }
  let(:results)  { preflight.check(filename) }

  context 'with PDF/X-1a' do
    context 'with subsettings' do
      let(:file_string) { 'pdfx-1a-subsetting' }

      it "correctly pass a valid PDF/X-1a file that uses font subsetting" do
        expect(results.empty?).to be(true)
      end
    end

    context 'without subsettings' do
      let(:file_string) { 'pdfx-1a-no-subsetting' }

      it "correctly pass a valid PDF/X-1a file that doesn't use font subsetting" do
        expect(results.empty?).to be(true)
      end
    end

    context 'with incompatible version' do
      let(:file_string) { 'version_1_4' }

      it "correctly detect files with an incompatible version" do
        expect(results.empty?).to be(false)
      end
    end

    context 'with a blank user password' do
      let(:file_string) { 'encrypted' }

      it "correctly detect encrypted files" do
        expect(results).to eql(["Can't preflight an encrypted PDF"])
      end
    end

    context 'with a user password' do
      let(:file_string) { 'encrypted_with_user_pass_apples' }

      it "correctly detect encrypted files with a user password" do
        expect(results).to eql(["Can't preflight an encrypted PDF"])
      end
    end

    it "should fail files that use object streams"
    it "should fail files that use xref streams"
  end

  context 'with PDF/X-4' do
    let(:file_string) { 'pdfx-4' }

    context 'without subsettings' do
      it "correctly pass a valid PDF/X-4 file that doesn't use font subsetting" do
        expect(results.empty?).to be(true)
      end
    end
  end
end
