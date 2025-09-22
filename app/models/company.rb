class Company < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :courses, dependent: :destroy
  has_many :security_tests, dependent: :destroy

  validates :name, :subdomain, :contact_email, presence: true
  validates :subdomain, uniqueness: true, format: { with: /\A[a-z0-9]+\z/ }

  before_validation :downcase_subdomain

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :archived, -> { where.not(deleted_at: nil) }

  # --- New helpers ---
  def active_users
    users.where(deleted_at: nil)
  end

  def active_user_count
    active_users.count
  end

  def user_limit_reached?
    max_users.present? && active_user_count >= max_users
  end

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end

  def archived?
    deleted_at.present?
  end

  private

  def downcase_subdomain
    self.subdomain = subdomain.downcase if subdomain.present?
  end
end
