# app/controllers/users/profiles_controller.rb
module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!   # ensures logged in
    before_action :set_user

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to edit_profile_path, notice: "Profile updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      # staff can update only their own details (no role/company)
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
