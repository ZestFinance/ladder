module Rater
  class TrueSkillRater
    def self.update_ratings winner, loser
      ratings_to_trueskill = {}
      ratings_to_trueskill[winner.rating] = winner.rating.to_trueskill
      ratings_to_trueskill[loser.rating] = loser.rating.to_trueskill

      trueskills_to_rank = { [ratings_to_trueskill[winner.rating]] => 1, [ratings_to_trueskill[loser.rating]] => 2}
      graph = Saulabs::TrueSkill::FactorGraph.new trueskills_to_rank
      graph.update_skills

      ratings_to_trueskill.each do |rating, trueskill|
        rating.update_rating! trueskill
      end
    end
  end
end
