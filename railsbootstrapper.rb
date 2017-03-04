#!/usr/bin/env ruby
require 'fileutils'

def gitignore_update
  # adding myself to .gitignore file
  puts "Adding myself to .gitignore so I'm not included in your git."
  File.open('.gitignore', 'a') do |file|
    file << 'railsbootstrapper.rb'
  end
  puts "Done\n\n"
end

def gemfile_update
  # appending to Gemfile
  puts 'Appending Gemfile with "gem bootstrap-sass v 3.3.6"'
  puts 'Make sure to run "bundle install" after I am done!'
  File.open('Gemfile', 'a') do |file|
    file << "gem 'bootstrap-sass', '~> 3.3.6'"
  end
  puts "Done\n\n"
end

def applicationcss_update
  # Rename extension for application.css to .scss for Sass
  puts 'Renaming application.css to application.scss'
  puts 'This file is in app/assets/stylesheets/'
  File.rename('app/assets/stylesheets/application.css',
              'app/assets/stylesheets/application.scss')
  puts "Done\n\n"
end

def application_cleanup
  # Remove all the *= require_self and *= require_tree from the sass file
  # We remove this because *= require in Sass then other stylesheets
  # will not be able to access the Bootstrap mixins or variables.
  # This opens the file and removes everything in it. Be careful.
  puts 'Removing all lines in application.scss before we add bootstrap'
  File.truncate('app/assets/stylesheets/application.scss', 0)
  puts "Done\n\n"
end

def import_bootstrapstyles
  # Import Bootstrap styles in app/assets/stylesheets/application.scss
  puts 'Importing bootstrap styles into application.scss'
  puts %(@import "bootstrap-sprockets";)
  puts %(@import "bootstrap";)
  FileUtils.cd('app/assets/stylesheets/') do
    File.open('application.scss', 'a') { |f|
      f << %(@import "bootstrap-sprockets";\n)
      f << %(@import "bootstrap";\n)
    }
  end
  puts "Done\n\n"
end

def import_javascript
  # Require Bootstrap Javascripts in app/assets/javascripts/application.js:
  puts 'Adding bootstrap into Javascripts in application.js'
  puts 'This file is in app/assets/javascripts/'
  puts '//= require jquery'
  puts '//= require bootstrap-sprockets'
  FileUtils.cd('app/assets/javascripts/') do
    File.open('application.js', 'a') { |f|
      f << "//= require jquery\n"
      f << "//= require bootstrap-sprockets\n"
    }
  end
  puts "Done\n\n"
end

def bundle_questions
  # I made this because linter was telling me I had too many lines.
  puts 'Almost done! We just need to update the gems for the app.'
  puts 'Would you like me to run "bundle install" for you? [y/n]'
  @bundle_answer = gets.chomp
end

def update_gemsbundle_install
  # Run bundler to update with bootstrap
  bundle_questions
  case @bundle_answer.downcase
  when 'yes', 'y'
    `bundle install`
    sleep(1)
    puts 'Bundle install command done.'
    puts "\n"
  when 'no', 'n'
    puts 'Okay. Just be sure to run "bundle install" later'
    puts "\n"
  else
    puts "Oops I didn't understand that answer. Try again."
    sleep(1)
    update_gemsbundle_install
  end
end

def create_pages_index
  puts 'Running command "rails g controller pages index"'
  `rails g controller pages index`
  puts 'Pages folder and index page created.'
end

def set_index_root
  puts 'Updating the config/routes.rb file'
  File.write("config/routes.rb", File.open("config/routes.rb",&:read).gsub("get","root"))

  File.write("config/routes.rb", File.open("config/routes.rb",&:read).gsub("pages/index","pages#index"))
  puts '"get pages/index" has been changed to "root pages#index in config/routes.rb'
  puts "\n"
end

def create_index
  # Run rails g controller pages new and set index as root
  puts 'Feeling ultra lazy?'
  puts 'I can create a pages folder, an index file and set it to root.'
  puts 'You will directed to the index page at the start of the rails server.'
  puts 'Would you like me to do this for you? [y/n]'
  create_answer = gets.chomp
  case create_answer.downcase
  when 'yes', 'y'
    create_pages_index
    sleep(1)
    set_index_root
  when 'no', 'n'
    puts 'Okay! No folders or pages were created.'
  else
    puts "Oops I didn't understand that answer. Try again."
    sleep(1)
    create_index
  end
end

puts "Hi, Let's get ready for some beeboppin' and Sass bootstrappin'."
puts "I will help with some set up steps for Bootstrap for Sass.\n"
puts "Just be sure that you're running me in the new rails app folder."
sleep(3)
puts "\n"
puts "I will let you know what I'm doing so we don't forget the steps."
puts "Let's start. Press the ENTER key to continue."

gets
sleep(1)
gitignore_update
sleep(1)
gemfile_update
sleep(1)
applicationcss_update
sleep(1)
application_cleanup
sleep(1)
import_bootstrapstyles
sleep(1)
import_javascript
sleep(1)
update_gemsbundle_install
sleep(1)
create_index
puts 'All done! Feel free to start the rails server.'
