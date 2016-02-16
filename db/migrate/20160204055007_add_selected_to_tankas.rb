class AddSelectedToTankas < ActiveRecord::Migration
  def change
    add_column :tankas, :selected, :boolean , :default => true
    add_column :tankas, :kin_cnt, :integer
    add_column :tankas, :ran_cnt, :integer
    add_column :tankas, :sho_cnt, :integer
    add_column :tankas, :ransho_cnt, :integer
  end
end
