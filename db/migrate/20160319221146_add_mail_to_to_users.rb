class AddMailToToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_to, :boolean
  end
end
