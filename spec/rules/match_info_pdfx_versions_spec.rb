require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::MatchInfoPdfxVersions do

  it "fails if argument is not a Hash" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)

    expect{ Preflight::Rules::MatchInfoPdfxVersions.new(/PDF\/X/).check_hash(ohash) }.to raise_error(ArgumentError)
  end

  let(:ohash) { PDF::Reader::ObjectHash.new(filename) }
  let(:chk)   { Preflight::Rules::MatchInfoPdfxVersions.new(checks) }
  let(:checks) do
    {
      PDFX_1a: [
        Preflight::Rules::MatchInfoEntries.new(:GTS_PDFXVersion => /\APDF\/X/, :GTS_PDFXConformance => /\APDF\/X-1a/),
        Preflight::Rules::MaxVersion.new(1.4)
      ],
      PDFX_4: [
        Preflight::Rules::MatchInfoEntries.new(:GTS_PDFXVersion => /\APDF\/X-4/),
        Preflight::Rules::MaxVersion.new(1.6)
      ]
    }
  end

  context "when providing a file that is not compliant at all with given PDFX versions" do
    let(:filename) { pdf_spec_file("no_document_id") }

    it "returns an list of errors" do
      expect(chk.check_hash(ohash)).to_not be_empty
    end

    it "includes format-specific errors" do
      errors = chk.check_hash(ohash)

      errors.each { |error|  expect(error.description[/Invalid file for PDFX_(1a|4)*/]).to_not be_nil }
    end
  end

  context "when providing a file that is not compliant with on of the PDFX attributes on a version" do
    let(:checks) do
      {
        PDFX_1a: [
          Preflight::Rules::MatchInfoEntries.new(:GTS_PDFXVersion => /\APDF\/X/, :GTS_PDFXConformance => /\APDF\/X-1a/),
          Preflight::Rules::MaxVersion.new(1.3) # Set 1.3 as max allowed version for pdfx_1a
        ],
        PDFX_4: [
          Preflight::Rules::MatchInfoEntries.new(:GTS_PDFXVersion => /\APDF\/X-4/),
          Preflight::Rules::MaxVersion.new(1.6)
        ]
      }
    end

    let(:filename) { pdf_spec_file("version_1_4") }

    it "returns an list of errors" do
      errors = chk.check_hash(ohash)

      pdfx_1a_error = errors.first.description
      expect(pdfx_1a_error).to include("Invalid file for PDFX_1a")
      expect(pdfx_1a_error).to include("max_version: 1.3, current_version: 1.4")

      pdfx_4_error  = errors.last.description
      expect(pdfx_4_error).to include("Invalid file for PDFX_4")
      expect(pdfx_4_error).to match(/GTS_PDFXVersion/)
    end
  end

  context "when providing a file that is compliant with PDFX-1a versions" do
    let(:filename) { pdf_spec_file("pdfx-1a-subsetting") }

    it "succeeds if file is compliant with PDFX-1A version" do
      expect(chk.check_hash(ohash)).to be_empty
    end
  end

  context "when providing a file that is compliant with PDFX-4 versions" do
    let(:filename) { pdf_spec_file("pdfx-4") }

    it "succeeds if file is compliant with PDFX-4 version" do
      expect(chk.check_hash(ohash)).to be_empty
    end
  end
end
