class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :authorizable, :polymorphic => true
  
  attr_accessible :name, :authorizable_type, :authorizable_id
  validates_presence_of :name
end