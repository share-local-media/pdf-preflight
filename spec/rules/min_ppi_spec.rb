require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::MinPpi do

  it "pass files with a no raster images" do
    filename = pdf_spec_file("pdfx-1a-subsetting")
    rule     = Preflight::Rules::MinPpi.new(300)

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to be_empty
    end
  end

  it "pass files with only 300 ppi raster images" do
    filename = pdf_spec_file("300ppi")
    rule     = Preflight::Rules::MinPpi.new(300)

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues).to be_empty
    end
  end

  it "fail files with a 75ppi raster image" do
    filename = pdf_spec_file("72ppi")
    rule     = Preflight::Rules::MinPpi.new(300)

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues.size).to eq(1)

      issue = rule.issues.first
      expect(issue.horizontal_ppi).to eq(72.0)
      expect(issue.vertical_ppi).to eq(72.0)
      expect(issue.top_left).to eq([36.0, 586.0])
      expect(issue.bottom_left).to eq([36, 133])
      expect(issue.bottom_right).to eq([640,133])
      expect(issue.top_right).to eq([640, 586])
    end
  end

  it "fail files with a 150ppi raster image within a Form XObject" do
    filename = pdf_spec_file("low_ppi_image_within_form_xobject")
    rule     = Preflight::Rules::MinPpi.new(200)

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues.size).to eq(1)

      issue = rule.issues.first
      expect(issue.horizontal_ppi).to eq(148.151)
      expect(issue.vertical_ppi).to eq(148.151)
      expect(issue.top_left).to eq([250.24502999999999, 492.52378999999996])
      expect(issue.bottom_left).to eq([250.24502999999999, 401.64329])
      expect(issue.bottom_right).to eq([323.14383999999995, 401.64329])
      expect(issue.top_right).to eq([323.14383999999995, 492.52378999999996])
    end
  end

  it "pass files with no raster images that use a Form XObject" do
    filename = pdf_spec_file("form_xobject")
    rule     = Preflight::Rules::MinPpi.new(300)

    PDF::Reader.open(filename) do |reader|
      reader.page(1).walk(rule)
      expect(rule.issues.size).to eq(0)
    end
  end

end
