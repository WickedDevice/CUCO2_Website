class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" if user.nil?
    @user = user
    @record = record
  end
  
  def index?
    true if(user)
    false if(user.nil?)
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true if(user)
  end

  def new?
    create?
  end

  def update?
    !record.user_id.nil? and record.user_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    !record.user_id.nil? and record.user_id == user.id
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end