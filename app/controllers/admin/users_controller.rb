# app/controllers/admin/users_controller.rb
module Admin
  class UsersController < ApplicationController
    before_action :authorize_company_admin
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = current_user.company.users.order(created_at: :desc)
    end

    def show
    end

    def new
      @user = current_user.company.users.build
    end

    def edit
    end

    def create
      @user = current_user.company.users.build(user_params)
      if @user.save
        redirect_to admin_user_path(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
    end

    private

    def set_user
      @user = current_user.company.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :role)
    end

    def authorize_company_admin
      unless current_user.company_admin? || current_user.super_user?
        flash[:alert] = "Access denied. Company admin privileges required."
        redirect_to root_path
      end
    end
  end
end