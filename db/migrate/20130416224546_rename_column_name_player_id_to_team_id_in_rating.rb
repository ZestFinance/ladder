class RenameColumnNamePlayerIdToTeamIdInRating < ActiveRecord::Migration
  def up
    change_table :ratings do |t|
      t.rename :player_id, :team_id
    end
  end


  def down
    change_table :ratings do |t|
      t.rename :team_id, :player_id
    end
  end
end
