class Status < ActiveRecord::Base

  # PrivatePerson gem
  acts_as_permissible :by => :user

  before_save  :tokenize_tags
  after_create :tokenize_mentions

  # Public Activity gem
  include PublicActivity::Model
  tracked :owner => :user

  # Acts as Taggable gem
  acts_as_taggable

  # Cooperative extension to the Coletivo gem
  acts_as_rateable

  # Acts as Opengraph gem
  acts_as_opengraph :values => {
      :type => 'website',
      :site_name => Cooperative.configuration.application_name
  }

  # Paperclip gem
  attr_reader :image_remote_url
  has_attached_file :image,
                    :styles => Cooperative.configuration.paperclip_options[:statuses],
                    :default_url => "/assets/cooperative/:style/missing.png",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"


  attr_accessible :body, :url, :title, :description, :image_remote_url, :shareable_id, :shareable_type, :tag_list, :media_url, :media_type
  validates_presence_of :body, :user

  belongs_to :user
  belongs_to :shareable, :polymorphic => true
  has_many :statuses, :as => :shareable
  has_many :comments, :as => :commentable

  def build_status(status = nil)
    status ||= Status.new
    status.shareable = self
    status.title ||= title
    status.description ||= description.present? ? description : body
    unless image_file_name.nil?
      status.image_file_name ||= image_file_name
    end
    unless media_url.nil?
      status.media_url ||= media_url
      status.media_type ||= media_type
    end
    status
  end

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

  def tokenize_tags
    self.tag_list = body.scan(/#([^\s\?,;:'"<>]+[^\s\?,;:'"<>\.-])/).join(',')
  end

  def tokenize_mentions
    for mention in body.scan /@([^\s\?,;:'"<>]+[^\s\?,;:'"<>\.-])/
      recipient = User.find_by_nickname(mention)
      if user.can? :mention, recipient
        create_activity(:mentioned_in, :owner => user, :recipient => recipient)
      end
    end
  end

  def url
    Cooperative::Engine.routes.url_helpers.status_url(id)
  end

  def og_image
    image.url(:thumb)
  end

  def title
    :status_by_nickname.l :nickname => user.nickname
  end
end