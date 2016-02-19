class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, :null => false
      t.boolean :deleted, default: false
      t.references :user, index: true
      t.references :tanka, index: true
      
      t.timestamps null: false
    end
  end
end
