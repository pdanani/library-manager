class BookController < ApplicationController

  layout 'admin'
  
  def books
    @page = params[:page].to_i
    @search = params[:search].to_s    
    @books = Book.search_books(params)    
    @nr_books = @books.size
    @nr_items_per_page = ApplicationRecord.nr_items_per_page
    @nr_pages = ApplicationRecord.get_nr_pages(@books)
    @previous_page = ApplicationRecord.get_previous_page(@page)
    @next_page = ApplicationRecord.get_next_page(@page, @nr_pages)
    @books = ApplicationRecord.get_page_of_objects(@books, @page)    
  end

  def add_book
    if cookies[:user_connected].to_s != "Administrator" then 
      flash[:error] = "Please login as an administrator." 
      redirect_to admin_index_path
    end
  end 

  def save_book
    if cookies[:user_connected].to_s != "Administrator" then 
      flash[:error] = "Please login as an administrator." 
      redirect_to admin_index_path
    end
    @errors = Book.save_book_errors(params)
    if @errors == "" then
      flash[:success] = 'The book was saved successfully.'
      Book.save_book(params)
      redirect_to admin_add_book_path
    else
      flash[:save_book_title] = params[:anything][:title].to_s 
      flash[:save_book_author] = params[:anything][:author].to_s 
      flash[:save_book_isbn] = params[:anything][:isbn].to_s 
      flash[:save_book_count_copies] = params[:anything][:count_copies].to_s 
      flash[:error] = @errors
      redirect_back(fallback_location: admin_index_path)
    end    
  end

  def show_book
    @id = params[:id].to_i
    @book = Book.find_by_id(@id)
    if @book == nil then
      flash[:error] = "Book with id " + @id.to_s + " wasn't found."
      redirect_to admin_index_path
     end
   end 

  def delete_book
    @it_worked = Book.delete_book(params[:id])
    if @it_worked == true then
      flash[:success] = "The book was deleted."
    else
      flash[:error] = "The book wasn't deleted."
    end
    redirect_back(fallback_location: admin_index_path)
  end 

  def update_title    
    @message = Book.update_title(params)
    if @message != "" then
      render json: @message, status: 400
    end 
  end

  def update_author
    @message = Book.update_author(params)
    if @message != "" then
      render json: @message, status: 400
    end 
  end

  def update_isbn
    @message = Book.update_isbn(params)
    if @message != "" then
      render json: @message, status: 400
    end 
  end

  def update_count_copies
    @message = Book.update_count_copies(params)
    if @message != "" then
      render json: @message, status: 400
    end 
  end
  
  def checkout_book
    if cookies[:user_connected].to_s != "Administrator" then 
      flash[:error] = "Please login as an administrator." 
      redirect_to admin_index_path
    else
      @errors = Book.checkout_book(params)
      if @errors == "" then 
        flash[:success] = "Checkout has succeeded."
        redirect_back(fallback_location: admin_books_path("search",  "sort", 1))
      else 
        flash[:error] = @errors
        redirect_back(fallback_location: admin_books_path("search",  "sort", 1))
      end
    end
  end

end
