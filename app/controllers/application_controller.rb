class ApplicationController < ActionController::Base
	before_action :set_current_user

	def set_current_user
		if params[:token].present?
			token = AuthToken.find_by device_token: params[:token]
			@current_user = token.user if token.present?
		end
	end
end
