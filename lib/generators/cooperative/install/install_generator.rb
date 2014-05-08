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
      unless ActiveRecord::Base.connection.table_exists? 'comments'
        migration_template 'migrate/create_comments_table.rb', 'db/migrate/create_comments_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'groups'
        migration_template 'migrate/create_groups_table.rb', 'db/migrate/create_groups_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'messages'
        migration_template 'migrate/create_messages_table.rb', 'db/migrate/create_messages_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'pages'
        migration_template 'migrate/create_pages_table.rb', 'db/migrate/create_pages_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'roles'
        migration_template 'migrate/create_roles_table.rb', 'db/migrate/create_roles_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'users_roles'
        migration_template 'migrate/create_users_roles_table.rb', 'db/migrate/create_users_roles_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'statuses'
        migration_template 'migrate/create_statuses_table.rb', 'db/migrate/create_statuses_table.rb' rescue output $!.message
      end
      unless ActiveRecord::Base.connection.table_exists? 'user'
        migration_template 'migrate/create_users_table.rb', 'db/migrate/create_users_table.rb' rescue output $!.message
      end
    end
    
    def install_chalk_dust
      unless ActiveRecord::Base.connection.table_exists? 'activity_items'
        output "Chalk Dust lets user keep up with what's happening", :magenta
        generate("chalk_dust:install_migrations")
      end
    end
    
    def install_acts_as_taggable_on
      unless ActiveRecord::Base.connection.table_exists? 'tags'
        output "Acts as Taggable On lets arbitrary models be taggable.", :magenta
        generate("acts_as_taggable_on:migration")
      end
    end

    def install_coletivo
      unless ActiveRecord::Base.connection.table_exists? 'person_ratings'
        output "Coletivo is a rating and recommendation engine.", :magenta
        generate("coletivo")
      end
    end

    def install_private_person
      unless ActiveRecord::Base.connection.table_exists? 'permissions'
        output "Private Person gives user control over their own privacy.", :magenta
        generate("private_person:install")
      end
    end

    def install_customizable_bootstrap
      output "Customizable Bootstrap gives you a set of files that will help you modify the appearance of Bootstrap with a set of SCSS files.", :magenta
      generate("customizable_bootstrap:install")
    end

    def install_devise
      output "Devise is used to authenticate user.", :magenta
      generate("user:install")
    end

    def add_route
      output "Adding Cooperative to your routes.rb file", :magenta
      gsub_file "config/routes.rb", /mount Cooperative::Engine => '\/.*', :as => 'cooperative'/, ''
      gsub_file "config/routes.rb", /devise_for :user, :class_name => 'User', :module => :user/, ''
      route("mount Cooperative::Engine => '/', :as => 'cooperative'\n  #devise_for :user, :class_name => 'User', :module => :user")
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