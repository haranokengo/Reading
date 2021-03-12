class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.integer :review_id
      t.string :content

      t.timestamps
    end
  end
end
