require 'rails/generators'

class AddCapistranoGemsGenerator < Rails::Generators::Base
  desc "Adds required Capistrano and Figaro gems to the Gemfile"

  def add_gems
    gemfile_path = "Gemfile"

    append_to_file gemfile_path, <<~GEMS

      gem 'figaro'

      group :development do
        gem 'capistrano'
        gem 'capistrano3-puma'
        gem 'capistrano-rails', require: false
        gem 'capistrano-bundler', require: false
        gem 'capistrano-rake', require: false
        gem 'capistrano-rvm'
        gem 'capistrano-sidekiq'
      end
    GEMS

    say "Gems added! Run `bundle install` to install them.", :green
  end
end
