class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :search, Question
    can :fakereg, User
    if user.blank?
      cannot :index, User
    else
      if user.admin?
        can :manage, :all
      else
        if user.expert?
          can :create, Answer
          can :manage, Answer, :user_id => user.id
        end
        can [:create, :new], Question
        can :show, User
        can [:edit, :update, :show, :destroy], User, :id => user.id
        cannot :index, User
      end
    end
  end
end
