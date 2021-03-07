class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, id: false do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false

      t.timestamps
    end
    add_foreign_key :bookcases, :books, column: :book_id, primary_key: :isbn
  end
end
