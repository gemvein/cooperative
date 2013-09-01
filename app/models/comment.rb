class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type
  validates_presence_of :body, :commentable

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end