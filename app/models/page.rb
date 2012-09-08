class Page < ActiveRecord::Base
  belongs_to :page
  belongs_to :user
  attr_accessible :body, :description, :keywords, :public, :slug, :title
end
