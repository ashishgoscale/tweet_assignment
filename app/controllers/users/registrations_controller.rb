# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :verify_authenticity_token

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user = User.find_by email: params[:user][:email] if params[:user].present?
    if user.present?
      render json: "{ error: 'User already register with us.'}", status: 200
    else
      user = User.new(user_params)
      if user.save
        token = user.generate_devise_token
        auth_token = user.auth_tokens.create(device_token: token)
        render json: AuthTokenSerializer.new(auth_token).serializable_hash, status: 200
      else
        render json: user.errors.messages, status: 200
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
