class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :ladder, default: 1
      t.string :name
      t.integer :rank

      t.timestamps
    end
  end
end
