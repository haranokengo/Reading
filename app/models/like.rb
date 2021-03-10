class Like < ApplicationRecord
  
  belongs_to :book, primary_key: "isbn"
  belongs_to :user
  
end
