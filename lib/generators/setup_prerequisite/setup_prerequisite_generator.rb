# lib/generators/replace_deploy/setup_prerequisite_generator.rb
class SetupPrerequisiteGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  # This generator will generate the setup_prerequisite.rake file
  def create_setup_prerequisite_file

    @deploy_user = ENV["DEPLOY_USER"] || "deploy"
    @deploy_path = ENV["DEPLOY_PATH"] || "/home/deploy"
    @app_path = ENV["APP_PATH"] || "/home/deploy/app"
    @env = ENV["ENVIRONMENT"] || "development"
    @server = ENV["SERVER"] || "localhost"


    template "setup_prerequisite.rake.erb", "lib/capistrano/tasks/setup_prerequisite.rake"
    template "puma.rb.erb","config/deployment/puma.rb"
    template "puma.service.erb","config/deployment/puma.service"
    template "production.rb.erb","config/deploy/production.rb"
    template "nginx.conf.erb","config/deployment/nginx.conf"
  end
end
