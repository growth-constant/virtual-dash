# frozen_string_literal: true
module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /user/sign_up
    #def new
    #  puts "overriding signup"
    #  #resource = User.from_omniauth(request.env["omniauth.auth"])
    #  fields = User.from_omniauth_to_fields(request.env["omniauth.auth"])
    #  params.merge(fields)
    #  puts params
    #  super
    #end

    # POST /user
    def create
      fields = User.from_omniauth_to_fields(session["devise.strava_data"])
      # params.require(:user).permit(
      #   :email, :password, :password_confirmation,
      #   :name, :first_name, :last_name, :image, :image_medium, 
      #   :city, :state, :country, :provider, :uid, :token, :token_expires_at, :refresh_token
      # )
      params[:user].merge!(fields)
      #params = params.merge(fields)
      super
    end

    # GET /resource/edit
    # def edit
    #  super
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
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(
        :sign_up, keys: [
          :name, :first_name, :last_name, :image, :image_medium, 
          :city, :state, :country, :provider, :uid, :token, :token_expires_at, :refresh_token
        ]
      )
    end

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
  end
end