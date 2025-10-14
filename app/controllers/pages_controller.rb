class PagesController < ApplicationController
   skip_before_action :authenticate_user!
  
  def phishing
  end

  def social_engineering
  end

  def password_security
  end

  def malware_awareness
  end

  def contact
  end
end
