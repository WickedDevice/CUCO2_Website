class PagePolicy < ApplicationPolicy

  def index?
  	user.admin?
  end

  def show?
  	true
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      return Page.none if user.nil?

      return scope if user.admin?
    end
  end
end
