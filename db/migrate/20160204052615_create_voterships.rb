class CreateVoterships < ActiveRecord::Migration
  def change
    create_table :voterships do |t|
      t.references :user, index: true
      t.references :tanka, index: true
      t.references :dai, index: true    
      t.string :type
      t.index [:user_id, :tanka_id, :dai_id, :type] ,unique: true
      t.timestamps null: false
    end
  end
end
