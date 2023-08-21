class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  NR_ITEMS_PER_PAGE = 20
  
  def self.nr_items_per_page
    return NR_ITEMS_PER_PAGE  
  end
  
  def self.get_previous_page(page)
    @previous_page = page.to_i - 1
    if @previous_page == 0 then @previous_page = 1 end
    return @previous_page
  end
  
  def self.get_next_page(page, nr_pages)
    @next_page = page.to_i + 1 
    if @next_page > nr_pages.to_i then @next_page = @next_page - 1 end
    return @next_page
  end
  
  def self.get_nr_pages(objects)
    @nr_objects = objects.size
    @no_items_per_page = NR_ITEMS_PER_PAGE
    @nr_pages = @nr_objects / @no_items_per_page
    if @nr_objects % @no_items_per_page > 0 or @nr_objects < @no_items_per_page then @nr_pages = @nr_pages +  1 end
    return @nr_pages
  end 
  
  def self.get_page_of_objects(objects, page)
    @no_items_per_page = NR_ITEMS_PER_PAGE
    @objects = objects.offset(@no_items_per_page * (page.to_i - 1)).limit(@no_items_per_page)
    return @objects
  end
  
  def self.is_integer_valid(number)
    if number.to_s =~ /^[0-9]*[1-9][0-9]*$/ or number.to_s == "0" then 
      return true
    else
      return false
    end
  end
  
  def self.is_isbn_valid(number)
    if number.to_s =~ /^\d\d\d\d\d\d\d\d\d\d$/ then 
      return true
    else
      return false
    end
  end
  
end
