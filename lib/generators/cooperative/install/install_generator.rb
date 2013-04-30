module Cooperative
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    require File.expand_path('../../utils', __FILE__)
    include Generators::Utils
    include Rails::Generators::Migration
    
    def hello
      output "Hello, Cooperative Installer is cooperative.  Let's get things started.", :magenta
    end
    
    # all public methods in here will be run in order
    def add_initializer
      output "To start with, you'll need an initializer.  This is where you put your configuration options.", :magenta
      template "initializer.rb", "config/initializers/cooperative.rb"
    end
    
    def install_rails_admin
      output "Next we're installing rails admin, because it's nifty.", :magenta
      generate("rails_admin:install")
      output "Only we've got some special settings for rails admin", :magenta
      gsub_file "config/initializers/rails_admin.rb", "config.main_app_name = ['Dummy', 'Admin']", "config.main_app_name = [Cooperative.configuration.application_name, 'Admin']"
    end
    
    def install_ckeditor
      output "Ckeditor provides WYSIWYG editing in rails admin.", :magenta
      generate("ckeditor:install", "--orm=active_record --backend=paperclip")
    end
    
    def add_route
      output "Adding Cooperative to your routes.rb file", :magenta
      gsub_file "config/routes.rb", /mount Cooperative::Engine => \'\/.*\', :as => \'cooperative\'/, ''
      route("mount Cooperative::Engine => '/', :as => 'cooperative'")
    end
    
    def remove_public_index
      if File.exists?(Rails.root.join("public/index.html"))
        answer = ask_for("Looks like you still have a public/index.html file.  May I delete it for you?", "Y")
        if answer =~ /^y/i
          remove_file("public/index.html")
        else
          output "You will need to delete it manually.", :magenta
        end
      end
    end
    
    def add_migrations
      unless ActiveRecord::Base.connection.table_exists? 'messages'
        migration_template 'migrate/create_messages_table.rb', 'db/migrate/create_messages_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'pages'
        migration_template 'migrate/create_pages_table.rb', 'db/migrate/create_pages_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'roles'
        migration_template 'migrate/create_roles_table.rb', 'db/migrate/create_roles_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'roles_users'
        migration_template 'migrate/create_roles_users_table.rb', 'db/migrate/create_roles_users_table.rb' rescue output $!.message
      end
      migration_template 'migrate/add_fields_to_users.rb', 'db/migrate/add_fields_to_users.rb' rescue output $!.message
      migration_template 'migrate/add_image_to_users.rb', 'db/migrate/add_image_to_users.rb' rescue output $!.message
    end
    
    def install_public_activity
      output "Public Activity lets users keep up with what's happening", :magenta
      generate("public_activity:migration")
    end
    
    def install_acts_as_follower
      output "Acts as Follower lets one model follow another.", :magenta
      generate("acts_as_follower")
    end
    
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end