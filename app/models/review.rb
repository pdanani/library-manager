class Review < ApplicationRecord

  scope :by_search_params, -> (search) {where("", )}

  def self.save_review_errors(params)
    @errors = ""
  
    @name = params["anything"]["name"].to_s
    @review = params["anything"]["review"]
    @book_id = params["anything"]["book_id"].to_i
      
    if @name == "" then @errors += "Name is empty." end
    if @review == "" then @errors += "Review is empty." end
    if params["anything"]["book_id"] == nil then 
      @errors += "Book is missing."
    else 
      book = Book.find_by_id(@book_id)
      if book == nil then 
        @errors += "Book with id '" + params["anything"]["book_id"].to_s + "' wasn't found."
      end
    end
     
    return @errors 
  end

  def self.save_review(params)
    @review = Review.new
    @name = params["anything"]["name"].to_s 
    @review_column = params["anything"]["review"] 
    @book_id = params["anything"]["book_id"].to_s 
    
    @review.name = @name
    @review.review = @review_column
    @review.book_id = @book_id

    @review.save!(:validate => false)
  end 

  def self.delete_review(id)
    @it_worked = false
    @review = Review.find_by_id(id)
    if @review != nil then
      @review.delete
      @it_worked = true
    end
    return @it_worked
  end

  def self.update_name(params)
    @id = params["pk"].to_i
    @value = params["value"].to_s
    if @value == "" then @value = nil end
    @review = Review.find_by_id(@id)
    if @review != nil then
      @review.name = @value
      @review.save!(:validate => false)
    end
  end

  def self.update_review(params)
    @id = params["pk"].to_i
    @value = params["value"]
    if @value == "" then @value = nil end
    @review = Review.find_by_id(@id)
    if @review != nil then
      @review.review = @value
      @review.save!(:validate => false)
    end
  end
  
end
