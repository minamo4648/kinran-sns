class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :subject, default: "KAKAIより"
      t.string :body, default: "こんにちは。短歌投稿サイトKAKAIです。"

      t.timestamps null: false
    end
  end
end
