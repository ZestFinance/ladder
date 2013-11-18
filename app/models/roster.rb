class Roster < ActiveRecord::Base
  belongs_to :player
  belongs_to :team

  private

  def roster_params
    params.permit :player_id, :team_id
  end
end
