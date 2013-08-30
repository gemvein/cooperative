class Group < ActiveRecord::Base
  attr_accessible :description, :name, :public, :tag_list
  validates_presence_of :name
  acts_as_taggable
  acts_as_authorizable
  
  def owner
    has_owners.first
  end
  
  def owner=(user)
    owner == user
  end

  def self.open_to_the_public
    where(:public => true)
  end
end
