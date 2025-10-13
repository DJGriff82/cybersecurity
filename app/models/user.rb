# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Only apply acts_as_tenant for non-super users
  acts_as_tenant :company, optional: true

  enum :role, {
    staff_user: 0,
    company_admin: 1,
    super_user: 2
  }, default: :staff_user

  belongs_to :company, optional: true
  
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Custom validation to allow super users without company
  validate :company_required_unless_super_user

  scope :active, -> { where(deleted_at: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def soft_delete
    update_column(:deleted_at, Time.current)
  end

  private

  def company_required_unless_super_user
    if company_id.blank? && !super_user?
      errors.add(:company, "must exist for non-super users")
    end
  end
end