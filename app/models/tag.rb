class Tag < ActsAsTaggableOn::Tag
  extend FriendlyId
  friendly_id :name

  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^(.+)_tagged_with$/
      run_tagged_with_method($1, *args, &block)
    elsif meth.to_s =~ /^recent_(.+)$/
      recent_taggables($1, *args, &block)
    else
      super # You *must* call super if you don't handle the
            # method, otherwise you'll mess up Ruby's method
            # lookup.
    end
  end

  def respond_to?(meth, include_private = nil)
    if meth =~ /^(.+)_tagged_with$/ || meth =~ /^recent_(.+)$/
      true
    else
      super
    end
  end

  def recent_taggables(taggable_type, *args, &block)
    taggable_type.classify.constantize.tagged_with(name).order('created_at DESC')
  end

  def run_tagged_with_method(attrs, *args, &block)
    # Make an array of attribute names
    attrs = attrs.split('_and_')

    found = []
    for attr in attrs
      found = found | attr.classify.constantize.tagged_with(name)
    end

    found
  end

  def self.total_item_counts
    taggings = ActsAsTaggableOn::Tagging.where('tag_id IN (?)', self.pluck(:id))

    named_tags = {}
    for tagging in taggings
      named_tags[tagging.tag.name] = {:name => tagging.tag.name, :count => tagging.tag.taggings.count}
    end
    named_tags.values
  end
  
end