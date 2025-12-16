require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::OutputIntentForPdfx do

  it "fail files with no OutputIntent for PDF/X" do
    filename = pdf_spec_file("pdfa-1a")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::OutputIntentForPdfx.new

    expect(chk.check_hash(ohash)).to_not be_empty
  end

  it "pass files with a single OutputIntent for PDF/X" do
    filename  = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::DocumentId.new

    expect(chk.check_hash(ohash)).to be_empty
  end

end
