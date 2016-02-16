class AddTargetToDais < ActiveRecord::Migration
  def change
    add_column :dais, :target_gender, :integer, :default => 0
    add_column :dais, :target_grade, :string, :default => "0"
    add_column :dais, :all_select, :boolean
    add_column :dais, :fase, :integer , :default => 1
    add_column :dais, :v_due, :datetime   

  end
end
