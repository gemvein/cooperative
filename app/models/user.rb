class User < ActiveRecord::Base
  # Authorization plugin
  acts_as_authorized_user
  acts_as_authorizable
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :nickname, :password, :password_confirmation, :remember_me, :public, :bio
  # attr_accessible :title, :body
  validates_presence_of :nickname
end
