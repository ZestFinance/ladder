class MatchesController < ApplicationController

  # GET /matches
  def index
    @matches = Match.all.sort_by { |x| x.updated_at}.reverse
  end

  # GET /matches/1
  def show
    @match = Match.find(params[:id])
  end

  # GET /matches/new
  def new
    ladder = params[:ladder].nil? ? 1 : params[:ladder]
    @teams = Team.all_active ladder
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
    @participants = [@match.challenger, @match.defender]
  end

  # POST /matches
  def create
    @match = Match.new(new_match_params)

    if @match.save
      Rater::TrueSkillRater.update_ratings @match.winner, @match.defender
      redirect_to ladder_index_path ladder: @match.ladder
    else
      @teams = Team.all_active @match.ladder
      render action: "new"
    end
  end

  # PUT /matches/1
  def update
    @match = Match.find(params[:id])

    if @match.update_attributes(params[:match])
      redirect_to ladder_index_path ladder: @match.ladder
    else
      render action: "edit"
    end
  end

  # DELETE /matches/1
  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_url
  end

  private

  def new_match_params
    new_params = params[:match].merge!({ winner_id: params[:match][:challenger_id] })
    new_params.permit :challenger_id, :defender_id, :winner_id
  end
end
