class RenameColumnNames < ActiveRecord::Migration
  def up
    rename_column :matches, :defender, :defender_id
    rename_column :matches, :challenger, :challenger_id
    rename_column :matches, :winner, :winner_id
  end

  def down
    rename_column :matches, :defender_id, :defender
    rename_column :matches, :challenger_id, :challenger
    rename_column :matches, :winner_id, :winner
  end
end
