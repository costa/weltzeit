require 'rails_helper'

describe Clock do

  it "validates time_zone_name" do

    expect(Clock.new(time_zone_name: "dummy")).to_not be_valid
    expect(Clock.new(time_zone_name: "Athens")).to be_valid
  end
end
