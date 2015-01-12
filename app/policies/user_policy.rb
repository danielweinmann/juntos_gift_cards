class UserPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope

    def resolve
      if user.admin?
        scope.all
      end
    end

  end

  def make_pending?
    update?
  end

  def make_regular?
    update?
  end

  def make_admin?
    update?
  end

  protected

  def is_owned_by?(user)
    user.present? && record == user
  end

end
