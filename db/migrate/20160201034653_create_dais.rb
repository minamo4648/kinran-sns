class CreateDais < ActiveRecord::Migration
  def change
    create_table :dais do |t|
      t.string :title, :null => false
      t.string :comment, :null => false
      t.datetime :due
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end