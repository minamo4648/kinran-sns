class CreateDais < ActiveRecord::Migration
  def change
    create_table :dais do |t|
      t.string :title
      t.string :comment
      t.datetime :due

      t.timestamps null: false
    end
  end
end
