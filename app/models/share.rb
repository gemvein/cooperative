class Share < ActiveRecord::Base
  
  attr_reader :image_remote_url
  has_attached_file :image, :styles => Cooperative.configuration.paperclip_options[:shares]

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  belongs_to :user
  belongs_to :shareable, :polymorphic => true
  
  attr_accessible :body, :shareable_id, :shareable_type, :url, :image_remote_url
  
  validates_presence_of :body
  
  validates_presence_of :url
  validates_format_of :url, 
    :with => /^(https?:\/\/)([\da-z\.-]+)\.?([a-z\.]{2,6})(:[0-9]+)?([\/\w \.-]*)*\/?$/
    
  before_validation :format_url

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # image_file_name == "face.png"
    # image_content_type == "image/png"
    @image_remote_url = url_value
  end
  
  def format_url
    self.url = "http://#{self.url}" unless self.url[/^https?/]
  end
  
end
