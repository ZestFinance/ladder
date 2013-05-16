class Rating < ActiveRecord::Base
  attr_accessible :deviation, :mean, :player_id, :value
  belongs_to :player

  def to_trueskill
    Saulabs::TrueSkill::Rating.new self.mean, self.deviation
  end

  # see wiki http://en.wikipedia.org/wiki/TrueSkill
  def update_rating!(trueskill)
    attributes = { value: (trueskill.mean - (3.0 * trueskill.deviation)),
                   mean: trueskill.mean,
                   deviation: trueskill.deviation }
    update_attributes! attributes
  end
end
