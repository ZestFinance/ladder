require 'spec_helper'

describe PlayersController do

  describe "#index" do
    before do
      Player.destroy_all
      @test_player = Player.create
    end
    it "assigns @test_player" do
      get :index
      assigns(:players).should eq([@test_player])
    end
    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "#show" do
    before { @test_player = Player.create }
    it "assigns a player" do
      get :show, id: @test_player.id
      assigns(:player).should eq(@test_player)
    end
    it "renders the show template" do
      get :show, id: @test_player.id
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
    before { @test_player = Player.create }
    it "renders the edit template" do
      get :edit, id: @test_player
      response.should render_template("edit")
    end
    describe "with bad params" do
      before do
        Player.delete_all
        @test_player = Player.create
      end

      it "Raise exception" do
        lambda {
          get :edit, id: (@test_player.id + 1)
        }.should raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#create" do
    it "creates a new player" do
      expect {
        post :create, last_name: "stalone"
      }.to change(Player, :count).by(1)
    end
    describe "with unsuccessful save" do
      before do
        test_player = mock_model(Player, :save => false)
        test_player.stub_chain(:teams, :<<)
        Player.stub!(:new).and_return(test_player)
      end
      it "renders new" do
        post :create, last_name: "stalone"
        response.should render_template("new")
      end
    end
  end

  describe "#update" do
    before { @test_player = Player.create }
    it "redirects to player" do
      get :update, id: @test_player
      response.should redirect_to (assigns(:player))
    end
    it "should have a notice" do
      get :update, id: @test_player
      flash[:notice].should eql 'Player was successfully updated.'
    end
    describe "with unsuccessful update" do
      before do
        @player = mock_model(Match, :update_attributes => false)
        Player.stub!(:find).with("1").and_return(@player)
      end
      it "redirects to edit" do
        get :update, id: 1
        response.should render_template("edit")
      end
    end
  end

  describe "#toggle_status" do
    before { @test_player = Player.create first_name: "bob", active: true }
    it "changes active setting of player" do
      post :toggle_status, id: @test_player.id
      player = Player.find(@test_player.id)
      player.active.should == false
    end
    describe "with bad params" do
      before do
        Player.delete_all
        @test_player = Player.create
      end
      it "Raise exception" do
        lambda {
          post :toggle_status, id: (@test_player.id + 1) #does not exist
        }.should raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end

