class TeamsController < ApplicationController
  # GET /teams
  def index
    @teams = Team.where(ladder: 2)
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team2 = Team.new
    @players = Player.where(active: true).order(:first_name)
  end

  # POST /team/team2
  def create
    @team = Team.new ladder: 2
    @team2 = Team.new
    @players = Player.where(active: true)

    begin
      players = [Player.find(params[:team][:players]), Player.find(params[:team2][:players])]
      @team.players << players

      if @team.save
        redirect_to teams_path
      else
        render action: "new"
      end

    rescue ActiveRecord::RecordNotFound
      render action: "new"
    end

  end

end
