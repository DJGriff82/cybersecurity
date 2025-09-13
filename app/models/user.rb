class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  enum role: { staff_user: 0, company_admin: 1, super_user: 2 }

  belongs_to :company, optional: true
  
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(deleted_at: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def soft_delete
    update_column(:deleted_at, Time.current)
  end
end