# At the end, Person = User makes polymorphic finders work.

class User < ActiveRecord::Base
  # PrivatePerson gem
  acts_as_permissor :of => [:following_users, :user_followers], :class_name => 'User'
  acts_as_permissible :by => :self
  after_create :create_default_permissions

  # Cancan gem
  delegate :can?, :cannot?, :to => :ability

  # Paperclip gem
  has_attached_file :image, 
      :styles => Cooperative.configuration.paperclip_options[:users], 
      :default_url => "/assets/cooperative/:style/missing.png",
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"

  # Acts as Opengraph gem
  acts_as_opengraph :values => {
      :type => 'profile',
      :site_name => Cooperative.configuration.application_name
  }

  # Acts as Follower gem
  acts_as_follower
  acts_as_followable

  # Acts as Taggable On gem
  acts_as_taggable_on :skills, :interests, :hobbies

  # Coletivo gem
  has_own_preferences

  # Public Activity gem
  include PublicActivity::Activist
  activist

  # Rolify Gem
  rolify

  # FriendlyId gem
  extend FriendlyId
  friendly_id :nickname
  
  # Devise gem
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :nickname, :password, :password_confirmation, :remember_me, :public, :bio, :image, :skill_list, :interest_list, :hobby_list
  validates_presence_of :nickname
  validate :nickname_valid?

  has_many :comments
  has_many :messages, :foreign_key => :recipient_id
  has_many :messages_as_sender, :class_name => 'Message', :foreign_key => :sender_id
  has_many :pages, :as => :pageable
  has_many :statuses

  def nickname_valid? #TODO test this method
    nickname.match /^([^\s\?,;:'"<>]*[^\s\?,;:'"<>\.-])$/
  end

  def show_me
    following_users.pluck(:id) << id
  end

  def activities
    Activity.where('id IN (?)', activities_as_owner_ids|activities_as_recipient_ids).order('created_at desc')
  end

  def activities_as_follower
    Activity.find_all_by_users(show_me)
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def message_trash
    Message.trash_by(self.id)
  end

  def title
    nickname
  end

  def url
    Cooperative::Engine.routes.url_helpers.person_url(id)
  end

  def path
    Cooperative::Engine.routes.url_helpers.person_path(id)
  end

  def og_image
    image.url(:thumb)
  end

  def create_default_permissions
    for type in %w{Activity Comment Page Status}
      self.wildcard_permit! 'following_users', type
      self.wildcard_permit! 'user_followers', type
    end
    self.permit! 'following_users', self
    self.permit! 'user_followers', self
  end
end

Person = User
