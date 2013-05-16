class Player < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :rank, :active, :id
  has_many :matches
  has_many :rosters
  has_many :teams, through: :rosters

  # returns fullname
  def fullname
    return "#{first_name} #{last_name}"
  end

end
