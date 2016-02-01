class AddGradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :grade, :integer
    add_column :users, :gender, :integer
    add_column :users, :holder, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
    add_column :users, :contributor, :boolean, default: true
    add_column :users, :nickname, :string, :unique => true
    add_column :users, :nickname_update, :date
  end
end
