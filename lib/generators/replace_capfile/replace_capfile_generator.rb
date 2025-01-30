require 'rails/generators'

class ReplaceCapfileGenerator < Rails::Generators::Base
  desc "Replaces the Capfile with a predefined configuration"

  def replace_capfile
    capfile_path = "Capfile"

    create_file capfile_path, <<~CAPFILE, force: true
      require 'capistrano/setup'
      require 'capistrano/deploy'
      require 'capistrano/rails'
      require 'capistrano/bundler'
      require 'capistrano/rvm'
      require "capistrano/rails/assets"
      require "capistrano/rails/migrations"
      require 'capistrano/puma'
      require "capistrano/scm/git"
      require 'capistrano/sidekiq'

      install_plugin Capistrano::SCM::Git
      install_plugin Capistrano::Puma  # Default puma tasks
      install_plugin Capistrano::Puma::Systemd
      install_plugin Capistrano::Puma, load_hooks: false
      install_plugin Capistrano::Sidekiq::Systemd

      # Load custom tasks from `lib/capistrano/tasks` if you have any defined
      Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
    CAPFILE

    say "Capfile has been replaced successfully!", :green
  end
end
