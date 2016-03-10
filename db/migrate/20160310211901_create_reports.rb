class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :sample_id
      t.integer :ze_score
    end
  end
end
