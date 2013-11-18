class Team < ActiveRecord::Base
  has_one :rating,  autosave: true, dependent: :destroy
  has_many :rosters
  has_many :players, through: :rosters
  validate :team_must_be_unique

  before_create :build_rating

  def build_rating
    if self.rating.nil?
      self.rating = Rating.new
    end
  end

  def team_must_be_unique
    if players.size > 1

      if (players.uniq { |x| x.id }).size < 2
        errors.add(:players, ": Players have to be different")
      else
        # make sure this is a unique player combination
        already_exist = Roster.from("rosters, rosters as r2").where("rosters.team_id = r2.team_id \
            and rosters.player_id = #{players[0].id} and r2.player_id = #{players[1].id}")

        errors.add(:players, ": This team already exists") if already_exist.size > 0 && already_exist[0].team_id != id
      end
    end
  end

  # returns fullname
  def fullname
    if ladder == 1
      return players[0].fullname
    else
      names = players.collect { |x| x.fullname }
      names.join('/')
    end
  end

  #returns fullname and rank
  def fullname_and_rank
    ranking = rank.nil? ? "unranked" : "\##{rank}"
    "#{ranking} - #{fullname}"
  end

  # returns true if all players are active
  def all_players_active
    players.find_by_active(false).nil?
  end

  # returns all teams that have all players active
  def self.all_active(ladder)
    # Can this be more efficient?
    Team.where(ladder: ladder)
      .includes(:players)
      .find_all { |x| x.all_players_active }
      .sort { |one, another| one.fullname <=> another.fullname }
  end

  # return all teams that a player is part off
  def self.all_by_player(player)
    Team.includes(:players).where("players.id = #{player.id}")
  end

  private

  def player_params
     params.permit :ladder, :name, :players, :rank
  end
end
