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
  
  rails_admin do
    list do
      field :name
    end
    edit do
      field :name
      field :description
      field :public
      field :tag_list
      field :owners
      field :moderators
      field :members
    end
  end
end
