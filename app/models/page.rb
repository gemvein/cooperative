class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
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
    '/pages/' + path_parts.join('/')
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
end
