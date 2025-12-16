require File.dirname(__FILE__) + "/spec_helper"

describe Preflight::Issue do
  describe "initialisation" do

    let!(:issue) do
      Preflight::Issue.new("Transparency detected",
                           Preflight::Rules::NoTransparency,
                           {:page => 1}
                          )
    end

    it "should return the description" do
      expect(issue.description).to eq("Transparency detected")
    end

    it "should return the rule as a symbol" do
      expect(issue.rule).to eq(:"Preflight::Rules::NoTransparency")
    end

    it "should return the attributes" do
      expect(issue.attributes).to eq({:page => 1})
    end

    it "should return the attributes via methods" do
      expect(issue.page).to eq(1)
    end

    it "should return true to a respond_to? call" do
      expect(issue.respond_to?(:page)).to be(true)
    end

  end
end
