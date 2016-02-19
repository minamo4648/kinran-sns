class CreateVoterships < ActiveRecord::Migration
  def change
    create_table :voterships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tanka, index: true, foreign_key: true
      t.references :dai, index: true , foreign_key: true
      t.string :type
      t.index [:user_id, :tanka_id, :dai_id, :type] ,unique: true
      t.timestamps null: false
    end
  end
end
