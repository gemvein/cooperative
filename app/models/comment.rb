class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body, :commentable
  attr_accessible :body, :commentable_id, :commentable_type

  def find_by_commentable(commentable)
    where(:commentable_id => commentable.id, :commentable_type => commentable.class.name)
  end
end