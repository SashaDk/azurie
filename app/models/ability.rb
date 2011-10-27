class Ability
  include CanCan::Ability

  def initialize(user)
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
        can :manage, User, :id => user.id
        cannot :index, User
      end
    end
    can :read, :all
  end
end
