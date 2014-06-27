class SensorDatumPolicy < ApplicationPolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end


  def index?
    true if(user) #However, user should (probably) be admin, unless using index to download a csv
  end

  def create?
    true
  end

  def new?
    user.admin?
  end

  def update?
    (!record.user_id.nil? and record.user_id == user.id) || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    (!record.user_id.nil? and record.user_id == user.id) || user.admin?
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      return SensorDatum.none if user.nil?

      return scope if user.admin?

      # May not be the fastest
      scope.where(device_id: Device.where(user_id: user.id))
    end
  end
end
