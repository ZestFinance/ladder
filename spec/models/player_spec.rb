require 'spec_helper'

describe Player do
  describe ".fullname" do
    it "returns first_name + last_name" do
      player = Player.create first_name: "Allen", last_name: "Jackson"
      player.fullname.should eq "Allen Jackson"
    end
  end
end
