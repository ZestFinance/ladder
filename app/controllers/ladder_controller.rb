class LadderController < ApplicationController
  def index
    @ladder = params[:ladder]
    @ladder = @ladder.nil? ? 1 : @ladder.to_i
    @ladder = 1 if (@ladder < 1 || @ladder > 2)
    @teams = Team.includes(:rating, :players).
                  where(ladder: @ladder).
                  find_all { |team| team.all_players_active }.
                  sort { |team1, team2| team2.rating.value <=> team1.rating.value }
  end
end
