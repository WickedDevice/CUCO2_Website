class UserPolicy < ApplicationPolicy
  
  def destroy?
  	user.id == record.id
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
    	scope
    end
  end
end
