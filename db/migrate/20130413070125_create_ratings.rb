class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :player_id
      t.integer :value, default: 0
      t.float :mean, default: 2500
      t.float :deviation, default: (2500/3)

      t.timestamps
    end
  end
end
