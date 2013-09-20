class Activity < PublicActivity::Activity

  # PrivatePerson gem
  acts_as_permissible :by => :owner

  def self.find_all_by_users(users)
    where("(owner_id IN (?) AND owner_type = 'User') OR (recipient_id IN (?) AND recipient_type = 'User')", users, users)
  end

end

class ::PublicActivity::Activity
  attr_accessible :key, :parameters, :owner, :recipient
end
