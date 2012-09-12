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
end
