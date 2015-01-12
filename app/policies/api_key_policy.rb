class ApiKeyPolicy < ApplicationPolicy

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

  def permitted_attributes
    [:expires_at]
  end

end
