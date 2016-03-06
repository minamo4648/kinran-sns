class CreateKogyos < ActiveRecord::Migration
  def change
    create_table :kogyos do |t|
      t.integer :pick_type, default: 1
      t.string :notice
      t.integer :place, default: 1
      t.integer :season, default: 0
      t.string :hokku_name
      t.datetime :next_due
      t.float :voting_hour
      t.float :thinking_hour, default: 48
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
