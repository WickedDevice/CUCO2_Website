class DevicePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      return Device.none if user.nil?
      scope.where user_id: user.id
    end
  end
end
