class Group < ActiveRecord::Base
  attr_accessible :description, :name, :public
  validates_presence_of :name
end
