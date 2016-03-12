class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :sample_id
      t.string :text
      t.string :sentiment_type
      t.float :sentiment_score
      t.string :gender
      t.timestamps(null: false)
    end
  end
end
