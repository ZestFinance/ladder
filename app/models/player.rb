class Player < ActiveRecord::Base
  has_many :matches
  has_many :rosters
  has_many :teams, through: :rosters

  # returns fullname
  def fullname
    return "#{first_name} #{last_name}"
  end

  private

  def player_params
    params.permit :email, :first_name, :last_name, :rank, :active, :id
  end
end
