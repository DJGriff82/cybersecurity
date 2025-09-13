# app/policies/user_policy.rb
class UserPolicy < ApplicationPolicy
  def index?
    user.super_user? || user.company_admin?
  end

  def show?
    user.super_user? || (user.company_admin? && record.company == user.company) || record == user
  end

  def create?
    user.super_user? || user.company_admin?
  end

  def update?
    user.super_user? || (user.company_admin? && record.company == user.company)
  end

  def destroy?
    user.super_user? || (user.company_admin? && record.company == user.company)
  end

  class Scope < Scope
    def resolve
      if user.super_user?
        scope.all
      elsif user.company_admin?
        scope.where(company: user.company)
      else
        scope.where(id: user.id)
      end
    end
  end
end