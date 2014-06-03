class ExperimentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      return scope.where(user_id: user.id) unless user.nil?
      return Experiment.none if user.nil?
    end
  end
end
