# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by email: params[:user][:email]
    if user.present?
      if user.valid_password?(params[:user][:password])
        token = user.generate_devise_token
        auth_token = user.auth_tokens.create(device_token: token)
        render json: AuthTokenSerializer.new(auth_token).serializable_hash, status: 200
      else
        render json: "{ error: 'username and password not match'}", status: 200
      end
    else
      render json: "{ error: 'User not found'}", status: 400
    end
  end

  # DELETE /resource/sign_out
  def destroy
    if @current_user.present?
      @current_user.auth_tokens.take.destroy
      render json: "{ success: 'Logout successfully' }"
    else
      render json: "{ error: 'Please Login in' }", status: 200
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
