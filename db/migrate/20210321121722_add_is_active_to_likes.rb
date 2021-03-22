class AddIsActiveToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :is_active, :boolean, default: false, null: false
  end
end
