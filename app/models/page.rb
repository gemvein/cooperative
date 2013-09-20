class Page < ActiveRecord::Base
  # PrivatePerson gem
  acts_as_permissible :by => :user

  # Public Activity gem
  include PublicActivity::Model
  tracked :owner => :pageable

  # Friendly ID gem
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :pageable

  # Acts as Taggable gem
  acts_as_taggable

  # Acts as Opengraph gem
  acts_as_opengraph :values => {
      :type => 'website',
      :site_name => Cooperative.configuration.application_name
  }

  # Accessible attributes
  attr_accessible :body, :description, :keywords, :public, :title, :parent_id, :tag_list

  # Required attributes
  validates_presence_of :slug, :title, :body

  # Relationships
  belongs_to :pageable, :polymorphic => true

  belongs_to :parent, :class_name => 'Page'
  has_many :children, :foreign_key => :parent_id, :class_name => 'Page'

  # Class methods
  def self.find_all_root_pages
    where({:pageable_id => [0, nil, '']})
  end

  def self.find_all_owned_pages
    where('pageable_id IS NOT NULL AND pageable_type IS NOT NULL')
  end
  
  def self.find_all_by_path(path)
    parts = path.split('/')
    conditions = {:parent_id => [0, nil, '']}
    for part in parts
      current_pages = self.where(conditions).where(:slug => part)
      conditions = { :parent_id => current_pages.pluck(:id) }
    end
    current_pages
  end
  
  def self.find_by_path(path)
    find_all_by_path(path).first
  end

  # Instance methods

  # This one has to do with the Friendly ID gem.
  def should_generate_new_friendly_id?
    new_record?
  end

  def ancestry
    if parent
      my_ancestry = parent.ancestry
      my_ancestry << parent
    else
      my_ancestry = []
    end
  end

  def path
    if pageable_type.blank?
      prefix = '/'
    elsif pageable_type == 'User'
      person = User.friendly.find(pageable_id)
      prefix = '/people/' + person.nickname + '/'
    end
    prefix + 'pages/' + path_parts.join('/')
  end

  def path_parts
    parts = []
    unless ancestry.empty?
      for ancestor in ancestry
        parts << ancestor.slug
      end
    end
    parts << slug
    parts
  end

  def test_path
    path_parts.join('/')
  end

  def url
    Cooperative::Engine.routes.url_helpers.page_url(id)
  end

  def og_image
    image.url(:thumb)
  end
end
