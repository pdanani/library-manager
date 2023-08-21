Rails.application.routes.draw do
  #Home controller
#   get '/', to: 'frontend#home', as: 'home'
  
  #Admin controller
  get '/', to: 'admin#index', as: 'admin_index'
  get '/admin/profile', to: 'admin#profile', as: 'admin_profile'
  get '/connect_user/:user_type', to: 'admin#connect_user', as: 'connect_user'
  
  #Book controller
  get '/admin/books/:search/:page', to: 'book#books', as: 'admin_books', :constraints => { :search => /[^\/]+/ }
  get '/admin/add_book', to: 'book#add_book', as: 'admin_add_book'
  post '/admin/save_book', to: 'book#save_book', as: 'admin_save_book'
  get '/admin/show_book/:id', to: 'book#show_book', as: 'admin_show_book'
  post '/admin_book_update_title', to: 'book#update_title', as: 'admin_book_update_title' 
  post '/admin_book_update_author', to: 'book#update_author', as: 'admin_book_update_author' 
  post '/admin_book_update_isbn', to: 'book#update_isbn', as: 'admin_book_update_isbn' 
  post '/admin_book_update_count_copies', to: 'book#update_count_copies', as: 'admin_book_update_count_copies' 
  get '/admin/delete_book/:id', to: 'book#delete_book', as: 'admin_delete_book'
  get '/checkout_book/:book_id', to: 'book#checkout_book', as: 'checkout_book'
  
  #Review controller
  get '/admin/reviews/:book_id', to: 'review#reviews', as: 'admin_reviews', :constraints => { :search => /[^\/]+/ }
  get '/admin/add_review/:book_id', to: 'review#add_review', as: 'admin_add_review'
  post '/admin/save_review', to: 'review#save_review', as: 'admin_save_review'
  post '/admin_review_update_name', to: 'review#update_name', as: 'admin_review_update_name' 
  post '/admin_review_update_review', to: 'review#update_review', as: 'admin_review_update_review' 
  get '/admin/delete_review/:id', to: 'review#delete_review', as: 'admin_delete_review'
  
  
end
