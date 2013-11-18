require 'spec_helper'

describe MatchesController do

  describe "#index" do
    before do
      Match.destroy_all
      team1 = Team.create
      team2 = Team.create
      @test_match = Match.create challenger_id: team1.id, defender_id: team2.id
    end
    it "assigns @matches" do
      get :index
      assigns(:matches).should eq([@test_match])
    end
    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "#show" do
    before do
      Match.destroy_all
      team1 = Team.create
      team2 = Team.create
      @test_match = Match.create challenger_id: team1.id, defender_id: team2.id
    end
    it "assigns a match" do
      get :show, id: @test_match.id
      assigns(:match).should eq(@test_match)
    end
    it "renders the show template" do
      get :show, id: @test_match.id
      response.should render_template("show")
    end
  end
  describe "#new" do
    it "renders the new template" do
      get :new
      response.should render_template("new")
    end
  end

  describe "#edit" do
    before do
      Match.destroy_all
      team1 = Team.create
      team2 = Team.create
      @test_match = Match.create challenger_id: team1.id, defender_id: team2.id
    end
    it "renders the edit template" do
      get :edit, id: @test_match
      response.should render_template("edit")
    end
    describe "with bad params" do
      before do
        Match.delete_all
        team1 = Team.create
        team2 = Team.create
        @test_match = Match.create challenger_id: team1.id, defender_id: team2.id
      end
      it "Raise exception" do
        lambda {
          get :edit, id: (@test_match.id + 1)
        }.should raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#create" do
    before do
      @team1 = Team.create
      @team2 = Team.create
    end

    context 'when successful' do
      before do
        Rater::TrueSkillRater.should_receive(:update_ratings).with(@team1, @team2)
      end

      it "creates a new match" do
        expect {
          post :create,  match: {challenger_id: @team1.id, defender_id: @team2.id}
        }.to change(Match, :count).by(1)
      end
    end

    context "with unsuccessful save" do
      before do
        @team1 = Team.create ladder: 1
        @team2 = Team.create
        Team.any_instance.stub(:fullname).and_return("A-Team")

        @match = mock_model(Match, save: false, challenger_id: @team1.id, ladder: 1)
        Match.stub!(:new).and_return(@match)
      end

      it "renders new" do
        post :create, match: {challenger_id: @team1.id, defender_id: @team2.id}
        response.should render_template("new")
      end
    end
  end

  describe "#update" do
    before do
      team1 = Team.create
      team2 = Team.create
      @test_match = Match.create challenger_id: team1.id, defender_id: team2.id,  winner_id: team1.id
    end
    it "redirects to ladder" do
      get :update, id: @test_match
      response.should redirect_to ladder_index_path ladder: 1
    end
    describe "with unsuccessful update" do
      before do
        @match = mock_model(Match, :update_attributes => false)
        Match.stub!(:find).with("1").and_return(@match)
      end
      it "redirects to edit" do
        get :update, id: 1
        response.should render_template("edit")
      end
    end
  end

  describe "#destroy" do
    before do
      team1 = Team.create
      team2 = Team.create
      @test_match = Match.create challenger_id: team1.id, defender_id: team2.id,  winner_id: team1.id
    end
    it "destroys match" do
      expect {
        delete :destroy, id: @test_match
      }.to change(Match, :count).by(-1)
    end
    describe "with bad params" do
      before do
        Match.delete_all
        team1 = Team.create
        team2 = Team.create
        @test_match = Match.new challenger_id: team1.id, defender_id: team2.id
        @test_match.save
      end
      it "Raise exception" do
        lambda {
          delete :destroy, id: (@test_match.id + 1)
        }.should raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end

