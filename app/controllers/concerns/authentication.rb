module Authentication
  def generate_token(user)
    salt = SecureRandom.hex(10)
    token = JsonWebToken.encode({ salt: salt })

    AllowedList.create!(
      token: token,
      salt: salt,
      expires_at: 24.hours.from_now,
      user: user
    )

    return token
  end

  def invalidate_token(token)
    allowed_token = AllowedList.find_by(token: token)
    return false unless allowed_token

    allowed_token.destroy
    true
  end

  def extract_token_from_header
    token = request.headers['Authorization'].to_s.split(' ').last
    raise TokenNotFound, 'Authorization token not provided' if token.blank?

    token
  end

  def set_current_user
    token = extract_token_from_header
    payload = JsonWebToken.decode(token)
    raise TokenNotFound, 'Invalid or expired token' unless payload

    salt = payload['salt']
    allowed = AllowedList.find_by(token: token, salt: salt)
    raise TokenNotFound, 'Token not in allowed list' unless allowed

    allowed.user
  end

  def authenticated?
    current_user.present?
  end

  def current_user
    @current ||= set_current_user
  end
end
