class FirstMigration < ActiveRecord::Migration[6.0]
  def change
    
    if table_exists? :books then
    else
      create_table :books do |t|
        t.timestamps
      end
    end 

    if table_exists? :reviews then
    else
      create_table :reviews do |t|
        t.timestamps
      end
    end 

    if column_exists? :books, :title then
    else
      add_column :books, :title, :string
    end 

    if column_exists? :books, :author then
    else
      add_column :books, :author, :string
    end 

    if column_exists? :books, :isbn then
    else
      add_column :books, :isbn, :string
    end 

    if column_exists? :books, :count_copies then
    else
      add_column :books, :count_copies, :integer
    end 

    if column_exists? :reviews, :name then
    else
      add_column :reviews, :name, :string
    end 

    if column_exists? :reviews, :review then
    else
      add_column :reviews, :review, :text
    end 

    if column_exists? :books, :title then
      if index_exists? :books, :title then
      else
        add_index :books, :title
      end 
    end

    if column_exists? :books, :author then
      if index_exists? :books, :author then
      else
        add_index :books, :author
      end 
    end

    if column_exists? :books, :isbn then
      if index_exists? :books, :isbn then
      else
        add_index :books, :isbn
      end 
    end
    
  end
end
