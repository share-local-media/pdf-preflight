require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::NoFontSubsets do

  it "fail files with a subsetted TTF font" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::NoFontSubsets.new

    expect(chk.check_hash(ohash)).not_to be_empty
  end

  it "pass files with a complete TTF font" do
    filename = pdf_spec_file("pdfx-1a-no-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::NoFontSubsets.new

    expect(chk.check_hash(ohash)).to be_empty
  end

end
