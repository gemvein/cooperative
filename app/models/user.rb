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
      :default_url => "/assets/cooperative/:style/missing.png"

  
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

  # Authorization gem
  acts_as_authorized_user # TODO: replace this gem's functionality, as it is not being actively maintained.

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

  has_many :messages, :foreign_key => :recipient_id
  has_many :messages_as_sender, :class_name => 'Message', :foreign_key => :sender_id
  has_many :pages, :as => :pageable
  has_many :statuses
  has_many :permissions
  accepts_nested_attributes_for :permissions

  def show_me
    following_users.pluck(:id) << id
  end

  def activities
    Activity.where('id IN (?)', activities_as_owner_ids|activities_as_recipient_ids).order('created_at desc').limit(10)
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

  def create_default_permissions
    for type in %w{User Activity Comment Page Status}
      temp = Permission.new({:permissible_type => type, :relationship_type => 'public'})
      temp.permissor = self
      temp.save!
    end
  end
end
