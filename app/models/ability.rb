class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new # guest current_user (not logged in)

    # Activities
    can [:index], Activity do |comment|
      !current_user.new_record?
    end

    # Comments
    can [:read, :rate], Comment do |comment|
      current_user.following?(comment.commentable.user)
    end
    can [:read, :rate], Comment, :user => current_user
    can :create, Comment if !current_user.new_record?
    can :destroy, Comment do |comment|
      current_user == comment.commentable.user
    end
    can :destroy, Comment, :user => current_user

    # Groups
    can :create, Group if !current_user.new_record?
    can :join, Group.open_to_the_public do |group|
      !( current_user.has_role?('moderator', group) or current_user.has_role?('owner', group))
    end
    can :join, Group do |group|
      current_user.has_role?('invitee', group)
    end
    can :leave, Group do |group|
      current_user.has_role? 'member', group
    end
    can :read, Group, :public => true
    can [:read, :participate], Group do |group|
      current_user.has_role?('member', group)
    end
    can [:read, :participate, :moderate], Group do |group|
      current_user.has_role?('moderator', group)
    end
    can [:read, :participate, :moderate, :manage], Group do |group|
      current_user.has_role?('owner', group)
    end

    # Pages
    can :read, Page, :public => true
    can :create, Page if !current_user.new_record?
    can :manage, Page, :pageable => current_user

    # Statuses
    can [:read, :rate], Status, :user => current_user
    can [:read, :rate], Status do |status|
      status.user.public?
    end
    can [:read, :rate], Status do |status|
      current_user.following?(status.user)
    end
    can [:create, :grab], Status if !current_user.new_record?
    can :destroy, Status, :user => current_user
    can :comment, Status, :user => current_user
    can :comment, Status do |status|
      status.user.public?
    end
    can :comment, Status do |status|
      current_user.following?(status.user)
    end

    # Users
    can [:read, :mention], User, :public => true
    can [:read, :mention], User, :id => current_user.id
    can [:read, :mention], User do |user|
      user.following?(current_user)
    end
    can [:read, :mention], User do |user|
      current_user.following?(user)
    end
  end
end
