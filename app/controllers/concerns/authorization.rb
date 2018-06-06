module Authorization

  def require_authorization
    authorize_failure unless authorized?
  end

  def authorized?
    login.present?
  end

  def authorize_failure
    render json: { status: 'Unauthorized' }, status: :unauthorized
  end


  def login
    @login ||= begin
      token = request.headers['Authorization'].to_s[/Token (.*)/, 1]
      name = json_web_token_decode(token) if token.present?
      Login.where(name: name).first if name.present?
    end
  end

  def json_web_token_decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first['name']
  rescue JWT::DecodeError => e
    logger.error("Failure decoding JWT token: #{token.inspect}: #{e.message}")
    nil
  end

  def json_web_token_encode(name, exp = 2.weeks.from_now)
    JWT.encode({ name: name, exp: exp.to_i }, Rails.application.secrets.secret_key_base)
  end

end
