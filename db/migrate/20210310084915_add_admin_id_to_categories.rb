class AddAdminIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :admin_id, :integer
  end
end
