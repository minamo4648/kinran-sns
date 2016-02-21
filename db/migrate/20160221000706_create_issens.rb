class CreateIssens < ActiveRecord::Migration
  def change
    create_table :issens do |t|
      t.string :body, :null => false
      t.references :user, index: true, foreign_key: true
      t.references :tanka, index: true, foreign_key: true

      t.index [:user_id, :tanka_id] ,unique: true      
      t.timestamps null: false
    end
  end
end
