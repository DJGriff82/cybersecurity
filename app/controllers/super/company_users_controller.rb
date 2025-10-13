require 'csv'

module Super
  class CompanyUsersController < ApplicationController
    before_action :set_company
    before_action :set_user, only: [:edit, :update, :destroy, :restore]

    # =====================
    # INDEX (List Users)
    # =====================
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

    # =====================
    # NEW / CREATE
    # =====================
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

    # =====================
    # EDIT / UPDATE
    # =====================
    def edit; end

    def update
      if @user.update(user_params)
        redirect_to super_company_users_path(@company), notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # =====================
    # ARCHIVE / RESTORE
    # =====================
    def destroy
      @user.soft_delete
      redirect_to super_company_users_path(@company), notice: "User archived."
    end

    def restore
      @user.update(deleted_at: nil)
      redirect_to super_company_users_path(@company), notice: "User restored."
    end

    # =====================
    # IMPORT USERS (CSV)
    # =====================
    def import
      if params[:file].blank?
        redirect_to super_company_users_path(@company), alert: "Please upload a CSV file."
        return
      end

      imported = 0
      failed = []

      CSV.foreach(params[:file].path, headers: true) do |row|
        data = row.to_h.symbolize_keys
        user = @company.users.new(
          first_name: data[:first_name],
          last_name:  data[:last_name],
          email:      data[:email],
          role:       data[:role] || "staff_user",
          password:   SecureRandom.hex(8)
        )

        if user.save
          imported += 1
          # Optional: send password reset instructions
          # user.send_reset_password_instructions
        else
          failed << "#{data[:email]} (#{user.errors.full_messages.join(', ')})"
        end
      end

      notice = "#{imported} user(s) imported successfully."
      notice += " Some failed: #{failed.join('; ')}" if failed.any?

      redirect_to super_company_users_path(@company), notice: notice
    rescue => e
      redirect_to super_company_users_path(@company), alert: "Import failed: #{e.message}"
    end

    # =====================
    # PRIVATE HELPERS
    # =====================
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
