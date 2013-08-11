class Tag < ActsAsTaggableOn::Tag
  extend FriendlyId
  friendly_id :name
  
  def users
    User.tagged_with(name)
  end
  
  def groups
    Group.tagged_with(name)
  end
  
  def pages
    Page.tagged_with(name)
  end
  
  def self.total_item_counts
    group_tags = Group.all_tag_counts
    user_tags = User.all_tag_counts
    page_tags = Page.all_tag_counts
    
    tags = group_tags|user_tags|page_tags
  end
  
end