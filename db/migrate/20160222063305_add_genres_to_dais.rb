class AddGenresToDais < ActiveRecord::Migration
  def change
    add_column :dais, :genre, :integer, :default => 0, :null => false
  end
end
