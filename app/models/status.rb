class Status < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  acts_as_taggable

  def new_comment(comment = nil)
    comment ||= Comment.new()
    comment.commentable = self
    comment
  end

  def new_status
    status = Status.new()
    status.shareable = self
    status.title = title
    status.description = description.present? ? description : body
    if !image_file_name.nil?
      status.image_file_name = image_file_name
    end
    if !media_url.nil?
      status.media_url = media_url
      status.media_type = media_type
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
  has_many :comments, :as => :commentable

  attr_accessible :body, :url, :title, :description, :image_remote_url, :shareable_id, :shareable_type, :tag_list, :media_url, :media_type
  validates_presence_of :body, :user

  def image_remote_url=(url_value)
    if url_value.length > 5
      self.image = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # image_file_name == "face.png"
      # image_content_type == "image/png"
      @image_remote_url = url_value
    end
  end

  def path
    Cooperative::Engine.routes.url_helpers.status_path(id)
  end
end
