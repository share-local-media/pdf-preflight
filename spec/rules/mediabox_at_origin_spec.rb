require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::MediaboxAtOrigin do

  it "pass files with the MediaBox at 0,0" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::MediaboxAtOrigin.new

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to be_empty
    end
  end

  it "fail files with the MediaBox not at 0,0" do
    filename = pdf_spec_file("mediabox_origin_not_zero")
    rule     = Preflight::Rules::MediaboxAtOrigin.new

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to_not be_empty
    end
  end

end
