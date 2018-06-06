class LoginsController < ApplicationController

  def show
    render json: Login.ordered, except: [:password_digest, :deleted_at]
  end

  def create
    name, password = params.values_at(:name, :password)
    login = Login.where(name: name).first
    if login
      login = login.authenticate(password)
    elsif Login.count < 2 # The app currently only supports two logins
      login = Login.create(name: name, password: password, password_confirmation: password)
    end
    if login
      render json: { token: json_web_token_encode(login.name) }
    else
      authorize_failure
    end
  end

end
