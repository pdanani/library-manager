class AdminController < ApplicationController
  
  before_action :set_tab

  private
  
  def set_tab
    @tab = "admin" 
  end
  
  public
  
  layout 'admin'
   
  def index
    
  end
  
  def connect_user
    cookies[:user_connected] = params[:user_type].to_s
    @user_connected_to_be_displayed = cookies[:user_connected].to_s
    if @user_connected_to_be_displayed == "Administrator" then @user_connected_to_be_displayed = "an Administrator" else @user_connected_to_be_displayed = "a Patron" end
    flash[:success] = "You are now connected as " + @user_connected_to_be_displayed + "."
    redirect_to admin_books_path("search", 1)
  end
  
end
