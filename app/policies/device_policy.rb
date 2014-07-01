class DevicePolicy < ApplicationPolicy
  def update?
  	!record.user_id.nil? and (record.user.admin? || record.user_id == user.id)
  end


  class Scope < Struct.new(:user, :scope)
    def resolve
      return scope.none if user.nil?
      scope.where(user_id: user.id)
    end
  end
end
