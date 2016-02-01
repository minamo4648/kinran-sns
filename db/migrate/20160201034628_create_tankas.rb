class CreateTankas < ActiveRecord::Migration
  def change
    create_table :tankas do |t|
      t.string :body
      t.boolean :exposed

      t.timestamps null: false
    end
  end
end
