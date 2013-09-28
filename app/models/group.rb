class Group < ActiveRecord::Base
  # Acts as Taggable gem
  acts_as_taggable

  # Rolify gem
  resourcify

  attr_accessible :description, :name, :public, :tag_list
  validates_presence_of :name

  def self.open_to_the_public
    where(:public => true)
  end
end
