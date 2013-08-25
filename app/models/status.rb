class Status < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  acts_as_taggable

  acts_as_commentable

  def new_comment
    Comment.new()
  end

  def new_status
    status = Status.new()
    status.shareable = self
    status.title = title
    status.description = description.present? ? description : body
    if !image_file_name.nil?
      status.image_file_name = image_file_name
    end
    status
  end
  
  attr_reader :image_remote_url
  has_attached_file :image, 
      :styles => Cooperative.configuration.paperclip_options[:statuses], 
      :default_url => "/assets/cooperative/:style/missing.png"
  
  belongs_to :user
  belongs_to :shareable, :polymorphic => true
  has_many :statuses, :as => :shareable

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
