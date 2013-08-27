class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body, :commentable
  attr_accessible :body, :commentable_id, :commentable_type
end