class CreateRengas < ActiveRecord::Migration
  def change
    create_table :rengas do |t|
      t.string :body
      t.boolean :selected, default: true
      t.boolean :picked, default:false
      t.references :user, index: true, foreign_key: true      
      t.references :kogyo, index: true, foreign_key: true      


      t.timestamps null: false
    end
  end
end
