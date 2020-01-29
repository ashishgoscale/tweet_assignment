class ApplicationController < ActionController::Base
	before_action :set_current_user

	def set_current_user
		binding.pry
		if params[:token].present?
			token = AuthToken.find_by device_token: params[:token]
			@current_user = token.user
		end
	end
end
