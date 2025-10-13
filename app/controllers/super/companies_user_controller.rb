module Super
  class CompanyUsersController < ApplicationController
    before_action :set_company
    before_action :set_user, only: [:edit, :update, :destroy, :restore]

    def index
      case params[:filter]
      when "archived"
        @users = @company.users.where.not(deleted_at: nil).order(created_at: :desc)
      when "all"
        @users = @company.users.order(created_at: :desc)
      else
        @users = @company.users.where(deleted_at: nil).order(created_at: :desc)
      end
    end

    def new
      @user = @company.users.build
    end

    def create
      @user = @company.users.build(user_params)
      if @user.save
        redirect_to super_company_users_path(@company), notice: "User created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to super_company_users_path(@company), notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.soft_delete
      redirect_to super_company_users_path(@company), notice: "User archived."
    end

    def restore
      @user.update(deleted_at: nil)
      redirect_to super_company_users_path(@company), notice: "User restored."
    end

    private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_user
      @user = @company.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
    end
  end
end
