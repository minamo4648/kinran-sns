class CreateNoteships < ActiveRecord::Migration
  def change
    create_table :noteships do |t|
      t.references :user, index: true
      t.references :notice, index: true

      t.index [:user_id, :notice_id] ,unique: true
      t.timestamps null: false
    end
  end
end
