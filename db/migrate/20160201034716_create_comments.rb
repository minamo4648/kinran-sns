class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.boolean :deleted, default: false
      t.references :user, index: true, foreign_key: true
      t.references :tanka, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
