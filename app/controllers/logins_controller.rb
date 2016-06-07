class LoginsController < ApplicationController

  def show
    @logins = Login.ordered
  end

  def create
    name, password = params[:login].values_at(:name, :password)
    login = Login.where(name: name).first
    if login
      login = login.authenticate(password)
    elsif Login.count < 2 # The app currently only supports two logins
      login = Login.create(name: name, password: password, password_confirmation: password)
    end
    if login
      session[:login] = login.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    reset_session
    redirect_to '/login'
  end

end
