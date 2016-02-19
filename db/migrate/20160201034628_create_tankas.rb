class CreateTankas < ActiveRecord::Migration
  def change
    create_table :tankas do |t|
      t.string :body
      t.boolean :exposed, default: true
      t.references :user, index: true, foreign_key: true
      t.references :dai, index: true
      
      t.timestamps null: false
    end
  end
end
