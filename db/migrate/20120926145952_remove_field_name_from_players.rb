class RemoveFieldNameFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :rank
  end

  def down
    add_column :players, :rank, :integer
  end
end
