class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :defender
      t.integer :challenger
      t.integer :winner

      t.timestamps
    end
  end
end
