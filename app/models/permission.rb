class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :permissible, :polymorphic => true

  attr_accessible :permissible, :permissible_type, :permissible_id, :whom
  validates_presence_of :user, :permissible_type, :whom
end