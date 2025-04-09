
module Authentication
  def generate_token(user)
    salt = SecureRandom.hex(10)
    token = JsonWebToken.encode({ salt: salt })

    AllowedToken.create!(
      token: token,
      salt: salt,
      expires_at: 24.hours.from_now
    )

    { token: token, salt: salt }
  end

  def invalidate_token(token)
    allowed_token = AllowedToken.find_by(token: token)
  
    if allowed_token
      allowed_token.destroy
      return true
    else
      return false unless allowed_token
    end
  end

  def extract_token_from_header(header)
    header.to_s.split(' ').last
  end
end
