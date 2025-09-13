class Company < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :courses, dependent: :destroy
  has_many :security_tests, dependent: :destroy

  validates :name, :subdomain, :contact_email, presence: true
  validates :subdomain, uniqueness: true, format: { with: /\A[a-z0-9]+\z/ }

  before_validation :downcase_subdomain

  private

  def downcase_subdomain
    self.subdomain = subdomain.downcase if subdomain.present?
  end
end