class Status < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  attr_reader :image_remote_url
  has_attached_file :image, :styles => Cooperative.configuration.paperclip_options[:statuses]
  
  belongs_to :user
  attr_accessible :body, :url, :title, :description, :image_remote_url
  validates_presence_of :body

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # image_file_name == "face.png"
    # image_content_type == "image/png"
    @image_remote_url = url_value
  end
end
