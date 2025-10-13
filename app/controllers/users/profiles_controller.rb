module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
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

    def destroy
      @user.soft_delete
      sign_out @user
      redirect_to root_path, notice: "Your account has been deactivated. If you would like all your data permanently erased, please contact support."
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
