class UserPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope

    def resolve
      if user.admin?
        scope.all
      end
    end

  end

  def create?
    is_admin?
  end

  def update?
    is_admin?
  end

  def destroy?
    is_admin?
  end

  def make_pending?
    is_admin?
  end

  def make_regular?
    is_admin?
  end

  def make_admin?
    is_admin?
  end

  protected

  def is_owned_by?(user)
    user.present? && record == user
  end

end
