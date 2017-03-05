<strong>Lazy Sass Rails Bootstrapper</strong>

A simple ruby script that makes changes to a new Rails application to make it compatible with Bootstrap for Sass.

This is what the script will do: 

  1. Add itself to .gitignore.

  2. Update Gemfile to include the bootstrap-sass gem. 
    > gem 'bootstrap-sass', '~> 3.3.6'

  3. Rename extension application.css to .scss for Bootstrap for Sass.

  4. Remove all the *= require_self and *= require_tree statements from the application.sass file.

  5. Import Bootstrap styles in app/assets/stylesheets/application.scss:
    > @import "bootstrap-sprockets";
    > @import "bootstrap";

  5.  Require Bootstrap Javascripts in app/assets/javascripts/application.js:
    > //= require jquery
    > //= require bootstrap-sprockets

  7. Give the option for script to run bundle install command to make new gem files available. 
    > bundle install

  8. Give the option for script to create a pages folder and an index.html file. The script will also set index as root.
    > rails g controller pages index

<strong>Installation</strong>

To download this script use:

   git clone https://github.com/ethankhoa/lazy-sass-rails-bootstrapper.git

The script will need to be run from the app folder that is created from the 'rails new' command. 


To run the script: 

	ruby railsbootstrapper.rb
	or
	ruby /folder/railsbootstrapper.rb
	


