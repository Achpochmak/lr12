class SessionController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]

  def login    
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      flash.now[:danger] = "Неверный логин или пароль."
    end 
  end

  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path
    else
      flash[:danger] = "Неверный логин или пароль."
      redirect_to session_login_path
    end
  end

  def logout
    cookies.permanent[:remember_token] = nil
    redirect_to session_login_path
  end

end
