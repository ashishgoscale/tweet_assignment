class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :follower_count do |user|
  	user.follower.count
  end

  attributes :following_count do |user|
  	user.following.count
  end
  
  attributes :my_details do |user|
  	UserSerializer.new(user)
  end


end
