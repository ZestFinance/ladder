require 'spec_helper'

describe TeamsController do

  # This should return the minimal set of attributes required to create a valid
  # Team. As you add validations to Team, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TeamsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe ".index" do
    it "assigns all teams as @teams" do
      team = Team.create ladder: 2
      get :index, {}, valid_session
      assigns(:teams).should eq([team])
    end
  end

  describe ".new" do
    before do
      Player.create
      Player.create active: false
    end
    it "assigns a new team as @team" do
      get :new, {}, valid_session
      assigns(:team).should be_a_new(Team)
      assigns(:team2).should be_a_new(Team)
      assigns(:players).count.should be == 1
    end
  end

  describe ".create" do
    before(:each) do
      Team.destroy_all
      @player1 = Player.create
      @player2 = Player.create
    end
    describe "with valid params" do
      it "creates a new Team" do
        expect {
          post :create, {team: {players: @player1.id}, team2: {players: @player2.id}}, valid_session
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
        post :create, {team: {players: @player1.id}, team2: {players: @player2.id}}, valid_session
        assigns(:team).should be_a(Team)
        assigns(:team).should be_persisted
      end

      it "redirects to the created team" do
        post :create, {team: {players: @player1.id}, team2: {players: @player2.id}}, valid_session
        response.should redirect_to(teams_path)
      end
    end

    describe "with the same player" do
      it "re-renders the 'new' template" do
        post :create, {team: {players: @player1.id}, team2: {players: @player1.id}}, valid_session
        response.should render_template("new")
      end
    end

    describe "with existing team combination" do
      it "re-renders the 'new' template" do
        Team.destroy_all
        team = Team.create
        team.players << [@player1, @player2]
        team.save!
        post :create, {team: {players: @player1.id}, team2: {players: @player2.id}}, valid_session
        response.should render_template("new")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        post :create, {:team => {}}, valid_session
        assigns(:team).should be_a_new(Team)
        assigns(:team2).should be_a_new(Team)
        assigns(:players).count.should be == 2
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Team.any_instance.stub(:save).and_return(false)
        post :create, {:team => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

end
