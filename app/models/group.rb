class Group < ActiveRecord::Base
  # Acts as Taggable gem
  acts_as_taggable

  # Rolify gem
  resourcify

  # Acts As Opengraph gem
  acts_as_opengraph :values => {
                                  :type => 'website',
                                  :site_name => Cooperative.configuration.application_name
                                }

  # Paperclip gem
  has_attached_file :image,
                    :styles => Cooperative.configuration.paperclip_options[:groups],
                    :default_url => "/assets/cooperative/:style/missing.png",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"

  attr_accessible :description, :name, :public, :tag_list
  validates_presence_of :name

  def self.open_to_the_public
    where(:public => true)
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
