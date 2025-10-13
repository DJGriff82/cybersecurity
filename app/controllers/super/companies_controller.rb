class Super::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :restore]

  def index
    @filter = params[:filter]

    @companies = Company.all

    case @filter
    when "active"
      @companies = @companies.active.select { |c| c.subscription_active? }
    when "expired"
      @companies = @companies.active.reject { |c| c.subscription_active? }
    when "archived"
      @companies = @companies.archived
    end
  end

  def show
    @users = @company.users
  end

  def new
    @company = Company.new
  end

  def edit
    @users = @company.users
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to [:super, @company], notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      redirect_to [:super, @company], notice: "Company was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.soft_delete
    redirect_to super_companies_url, notice: "Company was successfully archived."
  end

  def restore
    @company.restore
    redirect_to super_companies_url, notice: "Company was successfully restored."
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :name,
      :subdomain,
      :contact_email,
      :subscription_status,
      :subscription_expires_at,
      :max_users,
      :industry,
      :description
    )
  end
end
