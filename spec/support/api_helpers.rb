module ApiHelpers
  def authenticated_header(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end

  def json
    JSON.parse(response.body)
  end
end