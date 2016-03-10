class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.string :description
      t.string :content
      t.integer :user_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
