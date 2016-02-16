class AddSoultankaToUser < ActiveRecord::Migration
  def change
    add_column :users, :soultanka_id, :integer
  end
end
