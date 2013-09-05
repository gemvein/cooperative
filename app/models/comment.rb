class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type
  validates_presence_of :body, :commentable

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  def self.find_by_commentable(commentable)
    where("commentable_type = '#{commentable.class.name}'").where(:commentable_id => commentable.id)
  end
end