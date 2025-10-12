# app/controllers/super/users_controller.rb
module Super
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :toggle_active]
    before_action :require_super_user

    def index
      # show all, even disabled users
      @users = User.unscoped.includes(:company).order(created_at: :desc)
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to super_user_path(@user), notice: 'User was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        redirect_to super_user_path(@user), notice: 'User was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # ✅ Disable or enable a user (soft delete)
    def toggle_active
      if @user.deleted_at.present?
        @user.update(deleted_at: nil)
        msg = 'User re-enabled successfully.'
      else
        @user.update(deleted_at: Time.current)
        msg = 'User disabled successfully.'
      end
      redirect_to super_users_path, notice: msg
    end

    private

    def set_user
      # include disabled users
      @user = User.unscoped.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :role, :company_id)
    end

    def require_super_user
      redirect_to root_path, alert: "Access denied." unless current_user.super_user?
    end
  end
end
