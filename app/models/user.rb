class User < ActiveRecord::Base
  # Paperclip plugin
  has_attached_file :image, 
      :styles => Cooperative.configuration.paperclip_options[:users], 
      :default_url => "/assets/cooperative/:style/missing.png"

  
  # Acts as Follower plugin
  acts_as_follower
  acts_as_followable
  
  acts_as_taggable_on :skills, :interests, :hobbies

  include PublicActivity::Activist
  activist

  def activities
    ::PublicActivity::Activity.where('id IN (?)', activities_as_owner_ids|activities_as_recipient_ids).order('created_at desc')
  end

  # Authorization plugin
  acts_as_authorized_user

  # FriendlyId plugin
  extend FriendlyId
  friendly_id :nickname
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :nickname, :password, :password_confirmation, :remember_me, :public, :bio, :image, :skill_list, :interest_list, :hobby_list
  validates_presence_of :nickname
  
  has_many :messages, :foreign_key => :recipient_id

  has_many :pages, :as => :pageable
  has_many :statuses

  def to_param
    self.nickname
  end
  
  rails_admin do
    list do
      field :nickname
      field :current_sign_in_at
      field :last_sign_in_at
      field :sign_in_count
    end
    edit do
      field :nickname
      field :email
      field :public
      field :image
      field :bio do
        ckeditor true
      end
      group :stats do
        active false
        label 'User Statistics'
        field :sign_in_count
        field :current_sign_in_at
        field :current_sign_in_ip
        field :last_sign_in_at
        field :last_sign_in_ip
        field :reset_password_sent_at
        field :remember_created_at
      end
    end
  end
end
