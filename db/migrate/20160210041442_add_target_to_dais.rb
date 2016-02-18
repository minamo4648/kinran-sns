class AddTargetToDais < ActiveRecord::Migration
  def change
    add_column :dais, :target_gender, :integer, :default => 0
    add_column :dais, :target_grade, :string, :default => "0"
    add_column :dais, :all_select, :boolean, :default => true
    add_column :dais, :fase, :integer , :default => 1
    add_column :dais, :v_due, :datetime
    add_column :dais, :vote_closed, :boolean, :default => false

  end
end
