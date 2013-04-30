class Page < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :pageable
  def should_generate_new_friendly_id?
    new_record?
  end
  
  belongs_to :parent, :class_name => "Page"
  has_many :children, :foreign_key => :parent_id, :class_name => "Page"
  
  belongs_to :pageable, :polymorphic => true
  attr_accessible :body, :description, :keywords, :public, :title, :parent_id, :pageable_id, :pageable_type
  validates_presence_of :slug, :title, :body
  
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
      person = User.find(pageable_id)
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

  def self.find_all_root_pages
    self.where({:pageable_id => [0, nil, '']})
  end

  def self.find_all_by_user_id(user_id)
    self.where({:pageable_id => user_id, :pageable_type => 'User'})
  end
  
  def self.find_all_by_path(path)
    parts = path.split('/')
    conditions = {:parent_id => [0, nil, '']}
    for part in parts
      current_pages = self.where(conditions).find_all_by_slug(part)
      current_page_ids = []
      for current_page in current_pages
        current_page_ids << current_page.id
      end
      conditions = {:parent_id => current_page_ids}
    end
    current_pages
  end
  
  def self.find_by_path(path)
    self.find_all_by_path(path).first
  end
  
  rails_admin do
    list do
      field :parent
      field :pageable
      field :title
      field :keywords
    end
    edit do
      field :parent
      field :pageable
      field :public
      field :title
      field :keywords
      field :description
      field :body, :text do
        ckeditor true
      end
      field :children
    end
  end
end
