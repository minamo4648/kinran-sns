class CreateRengaVoterships < ActiveRecord::Migration
  def change
    create_table :renga_voterships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :renga, index: true, foreign_key: true
      t.references :kogyo, index: true , foreign_key: true
      
      t.timestamps null: false
    end
  end
end
