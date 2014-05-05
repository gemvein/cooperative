# At the end, Person = User makes polymorphic finders work.

class User < ActiveRecord::Base
  # PrivatePerson gem
  acts_as_permissor :of => [:subscribers, :publishers], :class_name => 'User'
  acts_as_permissible :by => :self
  after_create :after_create

  # Cancan gem
  delegate :can?, :cannot?, :to => :ability

  # Paperclip gem
  has_attached_file :image, 
      :styles => Cooperative.configuration.paperclip_options[:users], 
      :default_url => "/assets/cooperative/:style/missing.png"

  # Acts as Taggable On gem
  acts_as_taggable_on :skills, :interests, :hobbies

  # Coletivo gem
  has_own_preferences

  # Rolify gem
  rolify

  # FriendlyId gem
  extend FriendlyId
  friendly_id :nickname
  
  # Devise gem
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # attr_accessible :email, :nickname, :password, :password_confirmation, :remember_me, :public, :bio, :image, :skill_list, :interest_list, :hobby_list
  validates_presence_of :nickname

  has_many :comments
  has_many :messages, :foreign_key => :recipient_id
  has_many :messages_as_sender, :class_name => 'Message', :foreign_key => :sender_id
  has_many :pages, :as => :pageable
  has_many :statuses

  def ability
    @ability ||= Ability.new(self)
  end

  def message_trash
    Message.trash_by(self.id)
  end

  def after_create
    create_default_permissions
    self_subscribe
  end

  def create_default_permissions
    for type in %w{Comment Page Status}
      self.wildcard_permit! 'subscribers', type
      self.wildcard_permit! 'publishers', type
    end
    self.permit! 'subscribers', self
    self.permit! 'publishers', self
  end

  def self_subscribe
    ChalkDust.subscribe(self, :to => self)
  end

  def subscribers
    ChalkDust.subscribers_of(self)
  end

  def publishers
    ChalkDust.publishers_of(self)
  end

  def activities
    ChalkDust::ActivityItem.where(:performer => self)
  end

  def activities_as_subscriber
    ChalkDust.activity_feed_for(self, :topic => :all)
  end
end

Person = User
