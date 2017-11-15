module AuthenticationHelpers
  def login_as user
    request.headers.merge! Authorization: JsonWebToken.encode(user_id: user.to_param)
  end
end
