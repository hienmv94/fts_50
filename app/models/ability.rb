class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:create, :read, :update], Exam, user_id: user.id
      can [:show, :update], User, id: user.id
      can :read, Subject
    end
  end
end
