class RemoveAdminIdFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :admin_id, :integer
  end
end
