class CreateMylists < ActiveRecord::Migration
  def change
    create_table :mylists do |t|
      t.string :name
      t.string :email
      t.integer :age

      t.timestamps null: false
    end
  end
end
