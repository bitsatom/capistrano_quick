require 'rails/generators'

# Commands: rails generate replace_deploy YOUR_CUSTOM_REPO_URL

class ReplaceDeployGenerator < Rails::Generators::Base
  desc "Replaces the config/deploy.rb file with a predefined configuration"

  argument :repo_url, type: :string, default: 'git@github.com:expertwatch/bitsatom_emailer.git'

  def replace_deploy
    deploy_rb_path = "config/deploy.rb"
    app_name = Rails.application.class.module_parent.to_s.tableize.singularize
    create_file deploy_rb_path, <<~DEPLOY_RB, force: true
      # config valid for current version and patch releases of Capistrano
      lock "~> 3.19.2"

      set :application, "#{app_name}"
      set :repo_url, "#{repo_url}"
      set :user, 'deploy'
      set :puma_threads, [4, 16]
      set :puma_workers, 0
      # Don't change these unless you know what you're doing
      set :pty, true
      # set :format, :pretty
      # set :log_level, :debug
      set :use_sudo, false
      set :deploy_via, :remote_cache
      set :deploy_to, "/home/\#{fetch(:user)}/\#{fetch(:application)}"
      set :puma_bind, "unix://\#{shared_path}/tmp/sockets/puma.sock"
      set :puma_state, "\#{shared_path}/tmp/pids/puma.state"
      set :puma_pid, "\#{shared_path}/tmp/pids/puma.pid"
      set :puma_access_log, "\#{release_path}/log/puma.error.log"
      set :puma_error_log, "\#{release_path}/log/puma.access.log"
      set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
      set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
      set :puma_preload_app, true
      set :puma_worker_timeout, nil
      set :puma_init_active_record, true # Change to false when not using ActiveRecord

      ## Linked Files & Directories (Default None):
      set :linked_files, %w{config/database.yml}
      set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
      set :keep_releases, 5
      set :rvm_type, :user
      set :rvm_ruby_version, "ruby-3.2.2"
      set :puma_service_unit_name, "puma"
      set :puma_systemctl_user, :system

      # In order to set MODE=once
      set :mode, ENV.fetch('MODE', 'repeat')

      before "deploy:starting", "deploy:setup_prerequisite"

      before 'deploy:starting', 'deploy:set_rails_env'
      namespace :deploy do
        desc "Set Rails environment to \#{fetch(:rails_env, 'production')}"
        task :set_rails_env do
          on roles(:app) do
            execute "export RAILS_ENV=\#{fetch(:rails_env, 'production')}"
          end
        end
      end
    DEPLOY_RB

    say "config/deploy.rb has been replaced successfully!", :green
  end
end
