class AddMailokToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_ok, :boolean, default: true
  end
end