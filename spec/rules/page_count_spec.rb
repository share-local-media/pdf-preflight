require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::PageCount do

  it "should pass files with correct page count specified by Fixnum" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(1)

    expect(rule.check_hash(ohash)).to be_empty
  end

  it "should fail files with incorrect page count specified by Fixnum" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(2)

    expect(rule.check_hash(ohash)).to_not be_empty
  end

  it "should pass files with correct page count specified by range" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(1..2)

    expect(rule.check_hash(ohash)).to be_empty
  end

  it "should fail files with incorrect page count specified by range" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(2..3)

    expect(rule.check_hash(ohash)).to_not be_empty
  end

  it "should pass files with correct page count specified by array" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new([1, 2])

    expect(rule.check_hash(ohash)).to be_empty
  end

  it "should fail files with incorrect page count specified by array" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new([2, 3])

    expect(rule.check_hash(ohash)).to_not be_empty
  end

  it "should pass files with correct page count specified by :odd" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(:odd)

    expect(rule.check_hash(ohash)).to be_empty
  end

  it "should fail files with correct page count specified by :odd" do
    filename = pdf_spec_file("two_pages")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(:odd)

    expect(rule.check_hash(ohash)).to_not be_empty
  end

  it "should pass files with correct page count specified by :even" do
    filename = pdf_spec_file("two_pages")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(:even)

    expect(rule.check_hash(ohash)).to be_empty
  end

  it "should fail files with correct page count specified by :even" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    ohash    = PDF::Reader::ObjectHash.new(filename)
    rule     = Preflight::Rules::PageCount.new(:even)

    expect(rule.check_hash(ohash)).to_not be_empty
  end

end
