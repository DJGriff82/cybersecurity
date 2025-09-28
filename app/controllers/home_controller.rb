# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    # Redirect to appropriate dashboard if user is already signed in
    if user_signed_in?
      if current_user.super_user?
        redirect_to super_root_path
      elsif current_user.company_admin?
        # Only redirect to admin if user has a company
        if current_user.company
          redirect_to admin_root_path
        else
          # If company admin but no company, show error
          flash[:alert] = "Your account is not associated with any company. Please contact a super administrator."
          redirect_to courses_path
        end
      else
        redirect_to courses_path
      end
    end
  end
  def privacy
  end
end