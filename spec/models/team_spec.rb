require 'spec_helper'

describe Team do

  describe ".fullname" do
    it "returns first_name + last_name" do
      team = Team.create
      team.players.build first_name: "Allen", last_name: "Jackson"
      team.fullname.should eq "Allen Jackson"
    end
  end

  describe ".fullname_and_rank" do
    it "returns rank and first_name + last_name" do
      team = Team.create rank: 3
      team.players.build first_name: "Allen", last_name: "Jackson"
      team.fullname_and_rank.should eq "#3 - Allen Jackson"
    end

    it "returns unrank and first_name + last_name" do
      team = Team.create
      team.players.build first_name: "Allen", last_name: "Jackson"
      team.fullname_and_rank.should eq "unranked - Allen Jackson"
    end
  end

  describe "#all_active" do
    context "for teams with active / inactive players" do
      before do
        t0 = Team.create name: "one" # one active
        t1 = Team.create name: "two" # two active
        t2 = Team.create name: "tre" # one nonactive
        t3 = Team.create name: "fou" # one active, one nonactive
        t4 = Team.create name: "l2", ladder: 2 # different ladder

        t0.players.build
        t1.players.build
        t1.players.build
        t2.players.build active: false
        t3.players.build
        t3.players.build active: false
        t4.players.build
        t0.save; t1.save; t2.save; t3.save; t4.save
      end

      it "returns teams with active players" do
        active = Team.all_active 1
        active.count.should == 2
        active[0].name.should eq "one"
        active[1].name.should eq "two"
      end
    end

    context "in terms of sorting" do
      before do
        a_team = Team.create name: "A"
        b_team = Team.create name: "B"
        Team.any_instance.stub(:fullname).and_return("B", "A")
      end

      it "returns teams sorted alphabetically" do
        active = Team.all_active 1
        active[0].name.should eq "A"
        active[1].name.should eq "B"
      end
    end
  end

  describe "#all_by_player" do
    before(:each) do
      @p0 = Player.create first_name: "Allen"
      @p1 = Player.create first_name: "Bobby"
      @p2 = Player.create first_name: "Cathy"
      @p3 = Player.create first_name: "Debra"
      @p4 = Player.create first_name: "Eddie"

      @t0 = Team.create rank: 1, ladder: 2
      @t1 = Team.create rank: 2, ladder: 2
      @t2 = Team.create rank: 3, ladder: 2
      @t3 = Team.create rank: 3, ladder: 2

      @t0.players << @p0
      @t1.players << [@p0, @p2]
      @t2.players << @p3
      @t3.players << [@p1, @p3]
      @t0.save; @t1.save; @t2.save; @t3.save
    end

    it "should return the right number of teams" do
      Team.all_by_player(@p0).count.should == 2
      Team.all_by_player(@p1).count.should == 1
      Team.all_by_player(@p2).count.should == 1
      Team.all_by_player(@p3).count.should == 2
      Team.all_by_player(@p4).count.should == 0
    end
  end
end
