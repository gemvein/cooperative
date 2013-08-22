class Status < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  acts_as_taggable
  
  attr_reader :image_remote_url
  has_attached_file :image, 
      :styles => Cooperative.configuration.paperclip_options[:statuses], 
      :default_url => "/assets/cooperative/:style/missing.png"
  
  belongs_to :user
  belongs_to :shareable, :polymorphic => true

  attr_accessible :body, :url, :title, :description, :image_remote_url, :shareable_id, :shareable_type, :tag_list
  validates_presence_of :body

  def image_remote_url=(url_value)
    if url_value.length > 5
      self.image = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # image_file_name == "face.png"
      # image_content_type == "image/png"
      @image_remote_url = url_value
    end
  end
end
