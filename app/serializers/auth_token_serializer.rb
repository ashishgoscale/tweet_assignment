class AuthTokenSerializer
  include FastJsonapi::ObjectSerializer
  attributes :device_token

  attributes :user do |auth_token|
  	UserSerializer.new(auth_token.user)
  end

end
