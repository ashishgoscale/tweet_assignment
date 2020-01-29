class FollowsController < ApplicationController

	def follow_user
		if @current_user.present?
			is_already_follow = @current_user.follows.find_by(follow_id: params[:follow][:follow_id], is_follow: params[:follow][:is_follow])
			if is_already_follow.present?
				error_message = is_already_follow.is_follow == 1 ? 'Following' : 'Follower'
				render json: "{ error: Already #{error_message} }", status: 200
			else
				insert_record_follow_user
			end
		else
			render json: "{ error: 'Please Login in' }", status: 200
		end
	end

	private

	def insert_record_follow_user
		user = @current_user.follows.new(follow_params)
		user.save
		render json: FollowSerializer.new(user) , status: 200	
	end

	def follow_params
		params.require(:follow).permit(:follow_id, :is_follow)
	end
end
