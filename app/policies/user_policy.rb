class UserPolicy < Struct.new(:user, :record)#< ApplicationPolicy

  def method_missing *args
    #Very unwise...
  	true
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
    	scope.all
    end
  end
end
