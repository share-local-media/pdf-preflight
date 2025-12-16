require File.dirname(__FILE__) + "/../spec_helper"

describe Preflight::Rules::NoTransparency do

  context "a page with transparent xobjects" do
    let!(:filename) { pdf_spec_file("transparency") }

    it "should fail with an issue" do
      rule     = Preflight::Rules::NoTransparency.new

      PDF::Reader.open(filename) do |reader|
        reader.page(2).walk(rule)

        expect(rule.issues.size).to eq(1)

        issue = rule.issues.first
        expect(issue.rule).to eq(:"Preflight::Rules::NoTransparency")
        expect(issue.page).to eq(2)
        expect(issue.top_left).to eq([99.0, 540.89])
        expect(issue.bottom_left).to eq([99.0, 742.89])
        expect(issue.bottom_right).to eq([301.0, 742.89])
        expect(issue.top_right).to eq([301.0, 540.89])
      end
    end
  end

  context "a page without transparent xobjects" do
    let!(:filename) { pdf_spec_file("transparency") }

    it "should pass with no issues" do
      rule     = Preflight::Rules::NoTransparency.new

      PDF::Reader.open(filename) do |reader|
        reader.page(1).walk(rule)
        expect(rule.issues).to be_empty
      end
    end
  end

end
