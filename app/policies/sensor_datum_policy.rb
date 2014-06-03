class SensorDatumPolicy < ApplicationPolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
  	true
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      return SensorDatum.none if user.nil?
      # May not be the fastest
      SensorDatum.where(device_id: Device.where(user_id: user.id))
    end
  end
end
