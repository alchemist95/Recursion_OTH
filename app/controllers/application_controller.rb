class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery with: :exception
 protect_from_forgery with: :null_session
 helper_method :current_user
  helper_method :current_score
  helper_method :authenticate_user!
 
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

     private

   def authenticate
     if !current_user
       flash[:error] = "Please Sign In"
       redirect_to root_path
     end
  end



  def current_score
    if current_user == nil or current_user.score==nil
      @current_score = 0
    else
      @current_score = current_user.score
    end
    @current_score
  end

end
