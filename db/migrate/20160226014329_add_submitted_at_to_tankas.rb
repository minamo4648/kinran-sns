class AddSubmittedAtToTankas < ActiveRecord::Migration
  def change
    add_column :tankas, :submitted_at, :datetime, default: Time.zone.now
  end
end
