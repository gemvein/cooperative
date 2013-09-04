    NOT YET STABLE, DO NOT ATTEMPT USE

cooperative
===========

Cooperative is a Social Engine that provides Social Networking abilities for Rails 3 apps.

Designed as a full-service Rails 3 Mountable Engine, Cooperative can have you up and running with a functional website in minutes.

It uses devise for authentication, and incorporates a number of popular gems with a great deal of custom code, in order to provide the savvy developer with a head-start at developing any Social Web 2.0 application. Buzzwords?  We've got them all.

* Bootstrap
* Sass
* Jquery & Jquery UI
* Statuses, Comments, Pages, Posts, and Tags
* Users, Groups, and Roles
* Votes, Ratings, and resulting Recommendations based on Euclidean Distance and Pearson’s Correlation Coefficient

Installation
------------

First, add the gem to your Gemfile

    gem "cooperative", :git => "git://github.com/nerakdon/cooperative.git"
    
Next, run the following commands

    > bundle install
    > rails g cooperative:install
    > rake db:migrate

Add-ons
------------
* Cooperative plays nice with rails_admin gem, and they make great buddies.