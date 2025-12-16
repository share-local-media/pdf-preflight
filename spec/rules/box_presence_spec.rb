require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::BoxPresence do

  it "pass files with all required page boxes" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::BoxPresence.new(:all => [:MediaBox, :CropBox])

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to be_empty
    end
  end

  it "pass files with any required page boxes" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::BoxPresence.new(:any => [:MediaBox, :CropBox])

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to be_empty
    end
  end

  it "fail files without any required page boxes" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::BoxPresence.new(:any => [:ArtBox])

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).not_to be_empty
      issue = rule.issues[0]
      expect(issue.rule).to eq(:"Preflight::Rules::BoxPresence")
      expect(issue.page).to eq(1)
      expect(issue.description).to eq("page must have any of ArtBox")
    end

  end

  it "fail files without all required page boxes" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::BoxPresence.new(:all => [:ArtBox, :CropBox])

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).not_to be_empty
      issue = rule.issues[0]
      expect(issue.rule).to eq(:"Preflight::Rules::BoxPresence")
      expect(issue.page).to eq(1)
      expect(issue.description).to eq("page must have all of ArtBox, CropBox")
    end

  end

end
