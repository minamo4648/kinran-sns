class AddMailToToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_to, :boolean
    add_column :users, :last_mail, :datetime
    
  end
end
