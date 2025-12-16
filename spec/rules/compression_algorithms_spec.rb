require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::CompressionAlgorithms do

  it "correctly fail files with a disallowed compression algorithm" do
    filename = pdf_spec_file("jbig2")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::CompressionAlgorithms.new(:FlateDecode)

    expect(chk.check_hash(ohash)).not_to be_empty
  end

  it "correctly pass files without a disallowed compression algorithm" do
    filename = pdf_spec_file("version_1_4")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    chk      = Preflight::Rules::CompressionAlgorithms.new(:FlateDecode)

    expect(chk.check_hash(ohash)).to be_empty
  end

end
