class PlayersController < ApplicationController
  # GET /players
  def index
    @players = Player.order(:first_name).all
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(player_params[:id])
  end

  # POST /players
  def create
    @player = Player.new(player_params[:player])
    @player.teams << Team.new

    if @player.save
      redirect_to players_path
    else
      render action: "new"
    end
  end

  # PUT /players/1
  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(player_params[:player])
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render action: "edit"
    end
  end

  # POST /players/1
  def toggle_status
    player = Player.find(params[:id])
    player.active = !player.active
    player.save!
    redirect_to players_path
  end


  private

  def player_params
    params.permit :id, player: [:email, :first_name, :last_name, :rank, :active]
  end
end
