# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    email = params[:login][:email]
    password = params[:login][:password]

    @user = User.authenticate_with_credentials(email, password)
    if @user
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
