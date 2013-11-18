class Match < ActiveRecord::Base
  belongs_to :defender, class_name: Team, foreign_key: :defender_id
  belongs_to :challenger, class_name: Team, foreign_key: :challenger_id
  belongs_to :winner, class_name: Team, foreign_key: :winner_id
  validate :challenger_cannot_also_be_the_defender
  validate :player_can_only_be_in_one_team

  delegate :ladder, to: :defender

  def challenger_cannot_also_be_the_defender
    if (challenger_id == defender_id)
      errors.add(:defender_id, ": Challenger can not challenge themselves.")
    end
  end

  def player_can_only_be_in_one_team
    team1 = Team.where(id: challenger_id).includes(:players).limit(2)
    team2 = Team.where(id: defender_id).includes(:players).limit(2)

    return if team1[0].ladder == 1

    same_player = team1[0].players & team2[0].players

    if (same_player.size > 0)
      errors.add(:defender_id, ": A player can only be in one team for a match.")
    end
  end

  # returns matches played
  def self.total_matches(team)
    Match.where("winner_id is not null and (challenger_id = #{team.id} or defender_id = #{team.id})").count
  end

  #returns matches won
  def self.total_wins(team)
    Match.where("winner_id = #{team.id}").count
  end

  #returns matches lost
  def self.total_loses(team)
    Match.where("winner_id is not null and winner_id != #{team.id} and (challenger_id = #{team.id} or defender_id = #{team.id})").count
  end
end
