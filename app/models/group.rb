class Group < ActiveRecord::Base
  # Acts as Taggable gem
  acts_as_taggable

  # Authorization gem
  acts_as_authorizable # TODO: replace this gem's functionality, as it is not being actively maintained.

  attr_accessible :description, :name, :public, :tag_list
  validates_presence_of :name

  def self.open_to_the_public
    where(:public => true)
  end

  # TODO: replace owner and owner=
  def owner
    has_owners.first
  end
  
  def owner=(user)
    owner == user
  end
end
