require 'spec_helper'

describe "Match" do
  before(:each) do
    Match.destroy_all
    @t1 = Team.create
    @t2 = Team.create
    @t3 = Team.create

    @p1 = Player.create
    @p2 = Player.create
    @p3 = Player.create
    @t1.players << @p1
    @t2.players << [@p1, @p2]
    @t3.players << [@p3, @p1]
    @t1.save; @t2.save; @t3.save

    Match.create challenger_id: @t1.id, defender_id: @t2.id, winner_id: @t1.id
    Match.create challenger_id: @t1.id, defender_id: @t2.id
    Match.create challenger_id: @t1.id, defender_id: @t2.id, winner_id: @t1.id
    Match.create challenger_id: @t2.id, defender_id: @t1.id
    Match.create challenger_id: @t2.id, defender_id: @t3.id, winner_id: @t2.id

  end

  describe "#total_wins" do
    it "returns player's wins total" do
      Match.total_wins(@t1).should == 2
      Match.total_wins(@t2).should == 1
      Match.total_wins(@t3).should == 0
    end
  end

  describe "#total_loses" do
    it "returns player's loss total" do
      Match.total_loses(@t1).should == 0
      Match.total_loses(@t2).should == 2
      Match.total_loses(@t3).should == 1
    end
  end

  describe "#total_matches" do
    it "returns player's matches total" do
      Match.total_matches(@t1).should eq 2
      Match.total_matches(@t2).should eq 3
      Match.total_matches(@t3).should eq 1
    end
  end

  describe ".player_can_only_be_in_one_team" do
    before(:each) do
      Match.destroy_all
      @t4 = Team.create ladder: 2, name: "t4"
      @t5 = Team.create ladder: 2, name: "t5"
      @t6 = Team.create ladder: 2, name: "t6"

      @p1 = Player.create
      @p2 = Player.create
      @p3 = Player.create
      @p4 = Player.create
      @p5 = Player.create

      @t4.players << [@p1, @p2]
      @t5.players << [@p3, @p4]
      @t6.players << [@p1, @p5]
      @t4.save; @t5.save; @t6.save
    end
    it "success when all players are unique" do
      Match.create challenger_id: @t4.id, defender_id: @t5.id
      Match.count.should == 1
    end
    it "fails when all players are not unique" do
      Match.create challenger_id: @t4.id, defender_id: @t6.id
      Match.count.should == 0
    end
  end
end
