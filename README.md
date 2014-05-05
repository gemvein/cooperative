    NOT YET STABLE, DO NOT ATTEMPT USE

![Travis Status](https://travis-ci.org/nerakdon/cooperative.png)
[![Coverage Status](https://coveralls.io/repos/nerakdon/cooperative/badge.png?branch=rails4)](https://coveralls.io/r/nerakdon/cooperative?branch=rails4)

cooperative
===========

Cooperative is a Social Engine that provides the power of all the Social Networking mainstays for your Rails 4 apps.

Designed as a full-service Rails 4 Mountable Engine, Cooperative can have you up and running with a functional social networking website in minutes.

It uses devise for authentication, and incorporates a number of popular gems with a great deal of custom code, in order to provide the savvy developer with a head-start at developing any Social Web 2.0 application. Buzzwords?  We've got them all.

* Customizable Bootstrap with SASS
* jQuery & jQueryUI-Bootstrap
* Statuses, Comments, Pages, Posts, and Tags
* Users, Follows, Groups, and Roles
* Votes, Ratings, and (soon) the resulting Recommendations based on Euclidean Distance and Pearson’s Correlation Coefficient

Installation
------------

First, add the gem to your Gemfile

    gem 'cooperative', :git => 'git://github.com/nerakdon/cooperative.git'
    
Next, run the following commands

    > bundle install
    > rails g cooperative:install
    > rake db:migrate
