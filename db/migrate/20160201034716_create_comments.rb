class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.boolean :deleted, default: false

      t.timestamps null: false
    end
  end
end
