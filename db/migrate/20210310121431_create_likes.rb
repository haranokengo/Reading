class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, forregn_key: true
      t.references :book

      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
    #add_foreign_key :bookcases, :books, column: :book_id, primary_key: :isbn
  end
end
