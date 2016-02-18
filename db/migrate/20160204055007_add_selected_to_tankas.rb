class AddSelectedToTankas < ActiveRecord::Migration
  def change
    add_column :tankas, :selected, :boolean , :default => true
    add_column :tankas, :kin_cnt, :integer, :default => 0
    add_column :tankas, :ran_cnt, :integer, :default => 0
    add_column :tankas, :sho_cnt, :integer, :default => 0
    add_column :tankas, :ransho_cnt, :integer, :default => 0
  end
end
