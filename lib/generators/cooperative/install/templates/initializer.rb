Cooperative.configure do |config|
  # Your Application Name
  config.application_name = "Your Application Name Goes Here"
  config.application_description = "Meta tag description goes here."
  config.application_keywords = "Meta, tag, keywords, go, here"
  
  # Configuration for TinyMCE WYSIWYG Editor
  config.tinymce_options = {
    :mode => 'specific_textareas',
    :editor_selector => 'wysiwyg'
  }
  
  # Configuration for Paperclip Image Uploader
  config.paperclip_options = {
    :users => {:large => "600x600>", :medium => "300x300>", :thumb => "150x150>"},
    :statuses => {:large => "600x600>", :medium => "300x300>", :thumb => "150x150>"}
  }

  config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )

end