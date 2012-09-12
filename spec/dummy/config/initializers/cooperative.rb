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
end