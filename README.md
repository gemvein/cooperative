    NOT YET STABLE, DO NOT ATTEMPT USE

[![GitHub version](https://badge.fury.io/gh/nerakdon%2Fcooperative.svg)](http://badge.fury.io/gh/nerakdon%2Fcooperative)
[![Build Status](https://travis-ci.org/nerakdon/cooperative.svg)](https://travis-ci.org/nerakdon/cooperative)
[![Coverage Status](https://coveralls.io/repos/nerakdon/cooperative/badge.png)](https://coveralls.io/r/nerakdon/cooperative)

cooperative
===========

Cooperative is a Social Engine that provides the power of all the Social Networking mainstays for your Rails 4 apps.

Designed as a full-service Rails 4 Mountable Engine, Cooperative can have you up and running with a functional social networking website in minutes.

It uses devise for authentication, and incorporates a number of popular gems with a great deal of custom code, in order to provide the savvy developer with a head-start at developing any Social Web 2.0 application. Buzzwords?  We've got them all.

* Twitter Bootstrap provided by bootstrap-sass and souped up with bootswitch to swap out bootswatch themes.
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
