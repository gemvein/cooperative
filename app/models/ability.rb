class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new # guest current_user (not logged in)

    # Activities
    can [:index], Activity do |activity|
      current_user.is_permitted? activity.owner, activity
    end

    # Comments
    can [:read, :rate], Comment do |comment|
      current_user.is_permitted? comment.user, comment
    end
    can [:read, :rate], Comment, :user => current_user
    can :create, Comment do |comment|
      current_user.can?(:comment, comment.commentable)
    end
    can :destroy, Comment, :user => current_user
    can :destroy, Comment do |comment|
      current_user == comment.commentable.user
    end

    # Groups
    can [:new, :create], Group if !current_user.new_record?
    can :join, Group.open_to_the_public do |group|
      !( current_user.has_role?('moderator', group) or current_user.has_role?('owner', group))
    end
    can [:index, :join], Group do |group|
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
    can [:read, :participate, :moderate, :edit, :update, :destroy], Group do |group|
      current_user == group.owner
    end

    # Messages
    can :create, Message if !current_user.new_record?
    can [:read, :move], Message, :sender => current_user
    can [:read, :move, :reply], Message, :recipient => current_user
    cannot :reply, Message do |message|
      message.sender.follows.blocked.include? current_user
    end

    # Pages
    can :read, Page.find_all_root_pages
    can :read, Page.find_all_owned_pages do |page|
      page.is_public?
    end
    can :read, Page.find_all_owned_pages do |page|
      current_user.is_permitted?(page.pageable, page)
    end
    can :create, Page if !current_user.new_record?
    can :manage, Page, :pageable => current_user

    # Statuses
    can [:read, :rate, :comment], Status, :user => current_user
    can [:read, :rate, :comment], Status do |status|
      current_user.is_permitted?(status.user, status)
    end
    can [:create, :grab], Status if !current_user.new_record?
    can :destroy, Status, :user => current_user

    # People
    can [:read, :mention], User, :id => current_user.id
    can [:read, :mention], User do |user|
      current_user.is_permitted?(user, user)
    end
    can [:follow, :message], User if !current_user.new_record?
    cannot :message, User do |user|
      user.follows.blocked.include? current_user
    end
    cannot :message, User do |user|
      current_user.follows.blocked.include? user # No fair doing the opposite, either.
    end

    # Tags
    can [:read], Tag
  end
end
