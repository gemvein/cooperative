RailsAdmin.config do |config|
  config.authorize_with :cancan
  config.model Role do
    visible false
  end
  config.model Page do
    list do
      # field :parent
      # field :pageable
      field :title
      field :keywords
    end
    edit do
      configure :body, :text do
        ckeditor true
      end
      configure :slug do
        visible false
      end
    end
  end
end