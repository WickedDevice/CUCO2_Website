class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def new?
  	user.admin?
  end

  def show?
    (user.id == record.id) || user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    (user.id == record.id) || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
    	if user.admin?
    		return scope
    	end
    	scope.where(id: user.id)
    end
  end
end
