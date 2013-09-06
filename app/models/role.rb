class Role < ActiveRecord::Base
  attr_accessible :name, :authorizable_type, :authorizable_id, :authorizable
  validates_presence_of :name

  has_and_belongs_to_many :users
  belongs_to :authorizable, :polymorphic => true
end