class DevicePolicy < ApplicationPolicy
  def update?
  	user.admin? || (!record.user_id.nil? and (record.user.admin? || record.user_id == user.id))
  end

  def edit?
    update?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      return scope.none if user.nil?
      return scope if user.admin?
      scope.where(user_id: user.id)
    end
  end
end
