class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
  def should_generate_new_friendly_id?
    new_record?
  end
  
  belongs_to :page
  belongs_to :user
  attr_accessible :body, :description, :keywords, :public, :slug, :title
  validates_presence_of :slug
end
