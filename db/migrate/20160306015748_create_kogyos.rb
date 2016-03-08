class CreateKogyos < ActiveRecord::Migration
  def change
    create_table :kogyos do |t|
      t.integer :pick_type, default: 0
      t.string :notice, default: ""
      t.string :next_notice
      t.integer :place, default: 1
      t.integer :season, default: 0
      t.string :hokku_name
      t.datetime :next_due
      t.boolean :voting, default: false
      t.float :thinking_hour, default: 48
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
