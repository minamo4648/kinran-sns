class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :body
      t.string :link, :default => ""

      t.timestamps null: false
    end
  end
end
