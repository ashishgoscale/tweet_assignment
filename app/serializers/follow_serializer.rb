class FollowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user do |follow|
  	follow.user
  end
  attributes :follow do |follow|
  	follow.is_follow == 1 ? 'Following' : 'Follower'
  end

  attributes :follow_user do |follow|
  	user = User.find_by id: follow.follow_id
  	user.present? ? user : '-'
  end
end
