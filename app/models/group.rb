class Group < ActiveRecord::Base
  # Acts as Taggable gem
  acts_as_taggable

  # Authorization gem
  acts_as_authorizable

  # Acts As Opengraph gem
  acts_as_opengraph :values => {
                                  :type => 'website',
                                  :site_name => Cooperative.configuration.application_name
                                }

  attr_accessible :description, :name, :public, :tag_list
  validates_presence_of :name

  def self.open_to_the_public
    where(:public => true)
  end

  def owner
    has_owners.first
  end
  
  def owner=(user)
    owner == user
  end

  def url
    Cooperative::Engine.routes.url_helpers.group_url(id)
  end

  def path
    Cooperative::Engine.routes.url_helpers.group_path(id)
  end

  def og_image
    image.url(:thumb)
  end
end
