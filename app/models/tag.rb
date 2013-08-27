class Tag < ActsAsTaggableOn::Tag
  extend FriendlyId
  friendly_id :name

  def self.ids
    pluck(:id)
  end

  def self.total_item_counts
    taggings = ActsAsTaggableOn::Tagging.where('tag_id IN (?)', self.ids)

    named_tags = {}
    for tagging in taggings
      named_tags[tagging.tag.name] = {:name => tagging.tag.name, :count => tagging.tag.taggings.count}
    end
    named_tags.values
  end

  def method_missing(meth)
    if meth.to_s =~ /^(.+)_tagged_with$/
      run_tagged_with_method($1)
    else
      super # You *must* call super if you don't handle the
            # method, otherwise you'll mess up Ruby's method
            # lookup.
    end
  end

  def respond_to?(meth, include_private)
    if meth =~ /^(.+)_tagged_with$/
      true
    else
      super
    end
  end

  def run_tagged_with_method(attrs)
    # Make an array of attribute names
    attrs = attrs.split('_and_')

    found = []
    for attr in attrs
      found = found | attr.classify.constantize.tagged_with(name)
    end

    found
  end
  
end