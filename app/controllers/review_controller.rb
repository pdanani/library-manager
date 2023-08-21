class ReviewController < ApplicationController

  layout 'admin'
  
  def reviews
    @book_id = params[:book_id].to_i
    @book = Book.find_by_id(@book_id)
    if @book == nil then 
      flash[:error] = "Book with id '" + params[:book_id].to_s + "' wasn't found."
      redirect_to admin_index_path
    end
    @reviews = Review.where(:book_id => @book_id).order("id asc")
    @nr_reviews = @reviews.size
  end

  def add_review
    if cookies[:user_connected].to_s != "Patron" then 
      flash[:error] = "Please login as a patron." 
      redirect_to admin_index_path
    end
    @book_id = params[:book_id].to_i 
    @book = Book.find_by_id(@book_id)
    if @book == nil then 
      flash[:error] = "Book with id " + params[:book_id].to_s + " wasn't found." 
      redirect_to admin_index_path
    else 
      
    end
  end 
  
  def save_review
    if cookies[:user_connected].to_s != "Patron" then 
      flash[:error] = "Please login as a patron." 
      redirect_to admin_index_path
    end
    @errors = Review.save_review_errors(params)
    if @errors == "" then
      flash[:success] = 'The review was saved successfully.'
      Review.save_review(params)
      redirect_to admin_add_review_path(params[:anything][:book_id].to_i)
    else
      flash[:save_review_name] = params[:anything][:name].to_s 
      flash[:save_review_review] = params[:anything][:review].to_s 
      flash[:error] = @errors
      redirect_back(fallback_location: admin_index_path)
    end    
  end

  def delete_review
    @it_worked = Review.delete_review(params[:id])
    if @it_worked == true then
      flash[:success] = "The review was deleted."
    else
      flash[:error] = "The review wasn't deleted."
    end
    redirect_back(fallback_location: admin_index_path)
  end 

  def update_name
    Review.update_name(params)
  end

  def update_review
    Review.update_review(params)
  end

end
