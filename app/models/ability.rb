class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
      can :manage, :all
    end

    # Comments
    can :access, Comment do |comment|
      user.following? comment.commentable.user or user == comment.user
    end
    can :create, Comment do |comment|
      !user.new_record?
    end
    can :destroy, Comment do |comment|
      user == comment.commentable.user or user == comment.user
    end
    
    # Groups
    can :create, Group do |group|
      !user.new_record?
    end   
    can :join, Group do |group|
      group.public? and !( user.has_role? 'moderator', group or user.has_role? 'owner', group )
    end
    can :leave, Group do |group|
      user.has_role? 'member', group
    end
    can :access, Group do |group|
      group.public? or user.has_role? 'member', group or user.has_role? 'moderator', group or user.has_role? 'owner', group
    end
    can :participate, Group do |group|
      user.has_role? 'member', group or user.has_role? 'moderator', group or user.has_role? 'owner', group
    end
    can :moderate, Group do |group|
      user.has_role? 'moderator', group or user.has_role? 'owner', group
    end
    can :manage, Group, :owner => user

    # Pages
    can :access, Page, :public => true
    can :create, Page do |page|
      !user.new_record?
    end
    can :manage, Page, :pageable => user

    # Statuses
    can :access, Status do |status|
      status.user.public? or user.following? status.user or user == status.user
    end
    can :create, Status do |status|
      !user.new_record?
    end
    can :destroy, Status, :user => user
    can :comment, Status do |status|
      status.user.public? or user.following? status.user or user == status.user
    end
  end
end
