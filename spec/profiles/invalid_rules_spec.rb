require File.dirname(__FILE__) + "/../spec_helper"

class InvalidProfile
  include Preflight::Profile

  profile_name "invalid"

  rule String, 1.3
end

describe "Profile with an invalid rule" do

  it "should raise an exception" do
    filename = pdf_spec_file("version_1_4")
    preflight = InvalidProfile.new
    expect { preflight.check(filename) }.to raise_error(RuntimeError)
  end

end
