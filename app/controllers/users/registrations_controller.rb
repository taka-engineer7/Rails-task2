# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  before_action :authenticate_user!

  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    
    resource_updated = update_resource(resource, account_update_params)

    if resource_updated
      set_flash_message_for_update(resource, :updated)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to users_profile_path # 保存成功したらプロフィール画面へ
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :edit_profile # 保存失敗時も自作の edit_profile 画面を再表示する！
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

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
end
