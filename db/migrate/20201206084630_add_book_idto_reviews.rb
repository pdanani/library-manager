class AddBookIdtoReviews < ActiveRecord::Migration[6.0]
  def change
    if column_exists? :reviews, :book_id, :integer then 
    else
      add_column :reviews, :book_id, :integer
    end
  end
end
