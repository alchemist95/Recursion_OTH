class SessionsController < ApplicationController

  def new

  end

	  def create
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except 'extra'
    user = User.sign_in_from_omniauth auth
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in"
    redirect_to root_url
  end

  def destroy
   session[:user_id] = nil
   session[:omniauth] = nil
   redirect_to root_url, notice: "SIGNED OUT"
  end


end
