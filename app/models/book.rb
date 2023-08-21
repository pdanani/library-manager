class Book < ApplicationRecord

  scope :by_search_params, -> (search) {where("isbn like ? or author like ? or title like ? ", '%' + search.to_s + '%', '%' + search.to_s + '%', '%' + search.to_s + '%')}

  def self.search_books(params)
    @search = params["search"].to_s
     
    @books = Book.where(nil)

    if @search == "search" then
    else
      @books = @books.by_search_params(@search)
    end
 
    @sort = params["sort"].to_s
    if @sort != "all" and @sort != "sort" then 
      if @sort == "title_asc" then 
        @books = @books.order("title asc")
      end 
      if @sort == "title_desc" then 
        @books = @books.order("title desc")
      end
      if @sort == "author_asc" then 
        @books = @books.order("author asc")
      end 
      if @sort == "author_desc" then 
        @books = @books.order("author desc")
      end
      if @sort == "isbn_asc" then 
        @books = @books.order("isbn asc")
      end 
      if @sort == "isbn_desc" then 
        @books = @books.order("isbn desc")
      end
      if @sort == "count_copies_asc" then 
        @books = @books.order("count_copies asc")
      end 
      if @sort == "count_copies_desc" then 
        @books = @books.order("count_copies desc")
      end
    else
      @books = @books.order("id desc")
    end

    return @books
  end 

  def self.save_book_errors(params)
    @errors = ""
  
    @title = params["anything"]["title"].to_s
    @author = params["anything"]["author"].to_s
    @isbn = params["anything"]["isbn"].to_s
    @count_copies = params["anything"]["count_copies"].to_s
      
    if @title == "" then @errors += "Title is empty." end
    if @author == "" then @errors += "Author is empty." end
    if @isbn == "" then 
      @errors += "ISBN is empty." 
    elsif ApplicationRecord.is_isbn_valid(@isbn) == false then 
      @errors += "ISBN needs to be a 10 digit unique string."
    else 
      same_isbn_books = Book.where(:isbn => @isbn) 
      if same_isbn_books.size > 0 then 
        @errors += "ISBN is not unique."
      end
    end
    if @count_copies == "" then 
      @errors += "Copies is empty."
    elsif ApplicationRecord.is_integer_valid(@count_copies) == false then 
      @errors += "Copies has to be an integer."
    end
    
    
      
    return @errors 
  end

  def self.save_book(params)
    @book = Book.new
    @title = params["anything"]["title"].to_s 
    @author = params["anything"]["author"].to_s 
    @isbn = params["anything"]["isbn"].to_s 
    @count_copies = params["anything"]["count_copies"].to_i 
    
    @book.title = @title
    @book.author = @author
    @book.isbn = @isbn
    @book.count_copies = @count_copies

    @book.save!(:validate => false)
  end 

  def self.delete_book(id)
    @it_worked = false
    @book = Book.find_by_id(id)
    if @book != nil then
      Review.where(:book_id => id.to_i).destroy_all
      @book.delete
      @it_worked = true
    end
    return @it_worked
  end

  def self.update_title(params)
    @message = ""
    @id = params["pk"].to_i
    @value = params["value"].to_s
    if @value.to_s == "" then @message = "Title is empty." end
    if @message == "" then 
      if @value == "" then @value = nil end
      @book = Book.find_by_id(@id)
      if @book != nil then
        @book.title = @value
        @book.save!(:validate => false)
      end
    end
    return @message
  end

  def self.update_author(params)
    @message = ""
    @id = params["pk"].to_i
    @value = params["value"].to_s
    if @value.to_s == "" then @message = "Author is empty." end
    if @message == "" then 
      if @value == "" then @value = nil end
      @book = Book.find_by_id(@id)
      if @book != nil then
        @book.author = @value
        @book.save!(:validate => false)
      end
    end
    return @message
  end

  def self.update_isbn(params)
    @message = ""
    @id = params["pk"].to_i
    @value = params["value"].to_s
    if @value.to_s == "" then @message = "ISBN is empty." elsif ApplicationRecord.is_isbn_valid(@value) == false then @message = "ISBN needs to be a 10 digit unique string." else 
      same_isbn_books = Book.where(:isbn => @value) 
      if same_isbn_books.size > 0 then 
        @message += "ISBN is not unique."
      end
    end
    if @message == "" then 
      if @value == "" then @value = nil end
      @book = Book.find_by_id(@id)
      if @book != nil then
        @book.isbn = @value
        @book.save!(:validate => false)
      end
    end
    return @message
  end

  def self.update_count_copies(params)
    @message = ""
    @id = params["pk"].to_i
    @value = params["value"].to_i
    if @value.to_s == "" then @message = "Copies is empty." elsif ApplicationRecord.is_integer_valid(params["value"].to_s) == false then @message = "Copies has to be an integer." end
    if @message == "" then 
      if @value == "" then @value = nil end
      @book = Book.find_by_id(@id)
      if @book != nil then
        @book.count_copies = @value
        @book.save!(:validate => false)
      end
    end
    return @message
  end

  def self.checkout_book(params)
    errors = ""
    book_id = params["book_id"].to_i
    book = Book.find_by_id(book_id)
    if book == nil then 
      errors += "Book with id '" + params[book_id].to_s + "' wasn't found."
    else
      if book.count_copies.to_i == 0 then
        errors += "Unable to checkout because there are no copies available."
      else 
        book.count_copies = book.count_copies.to_i - 1
        book.save
      end
    end
    return errors
  end
  
end
