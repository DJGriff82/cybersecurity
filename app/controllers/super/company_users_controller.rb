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

      CSV.foreach(params[:file].path, headers: true, col_sep: detect_separator(params[:file].path)) do |row|
        data = row.to_h.transform_keys do |key|
          key.to_s.strip.downcase.gsub(' ', '_').to_sym
        end

        normalized_role = normalize_role(data[:role])

        user = @company.users.new(
          first_name: data[:first_name],
          last_name:  data[:last_name],
          email:      data[:email],
          role:       normalized_role,
          password:   SecureRandom.hex(8)
        )

        if user.save
          imported += 1
          user.send_reset_password_instructions 
        else
          failed << "#{data[:email] || 'N/A'} (#{user.errors.full_messages.join(', ')})"
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

    # --- helper: normalize role names from CSV ---
    def normalize_role(role_value)
      return "staff_user" if role_value.blank?

      case role_value.to_s.strip.downcase
      when "staff", "employee", "user"
        "staff_user"
      when "admin", "company_admin"
        "company_admin"
      when "super", "super_admin", "super_user"
        "super_user"
      else
        "staff_user" # fallback default
      end
    end

    # --- helper: detect whether CSV uses tabs or commas ---
    def detect_separator(file_path)
      sample = File.open(file_path, &:readline)
      sample.include?("\t") ? "\t" : ","
    end
  end
end
