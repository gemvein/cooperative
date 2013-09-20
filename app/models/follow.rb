class Follow < ActiveRecord::Base

  attr_accessible :followable_type, :followable_id

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  def block!
    self.update_attribute(:blocked, true)
  end

  def self.to_json
    formatted_follows = []
    for follow in self.all
      formatted_follows << {:val => follow.followable.nickname || follow.followable.name, :meta => follow.followable.image.url(:thumb)}
    end
    formatted_follows.to_json
  end

end
