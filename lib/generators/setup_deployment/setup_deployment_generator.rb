class SetupDeploymentGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def ask_for_environment
    # Prompt the user to input either 'production' or 'staging'
    environment = ask("Please specify the environment (production/staging):", default: "production")

    # Ensure the environment is valid
    unless ["production", "staging"].include?(environment)
      say "Invalid environment specified. Defaulting to production.", :red
      environment = "production"
    end

    # Set the environment variable
    @env = environment
  end

  def ask_for_server
    @server = ask("Please specify the server (localhost/demo.bitsatom.com/127.0.0.1):", default: "localhost")

    if @server.empty?
      say "The server cannot be empty, using the default: localhost", :red
      @server = "localhost"
    end
  end

  def ask_for_deploy_user
    # Prompt the user for the custom deploy user
    @deploy_user = ask("Please specify the deploy user (e.g., deploy):", default: "ubuntu")

    # Ensure the deploy user is not empty
    if @deploy_user.empty?
      say "The deployment path cannot be empty, using the default: ubuntu", :red
      @deploy_user = "deploy"
    end
  end

  def ask_for_app_name
    # Prompt the user for the custom app_name
    @app_name = ask("Please specify the app name (e.g., bitsatom_emailer):", default: "bitsatom_emailer")

    # Ensure the path is not empty
    if @app_name.empty?
      say "The app name cannot be empty, using the default: bitsatom_emailer", :red
      @app_name = "bitsatom_emailer"
    end
  end

  def run_all_generators
    # Ask the user for the environment (production/staging)
    # ask_for_environment
    # ask_for_app_name
    # ask_for_deploy_user

    @deploy_path = "/home/#{@deploy_user}"
    @app_path = "/home/#{@deploy_user}/#{@app_name}"

    ENV["DEPLOY_USER"] = @deploy_user
    ENV["DEPLOY_PATH"] = @deploy_path
    ENV["APP_PATH"] = @app_path
    ENV["ENVIRONMENT"] = @env
    ENV["SERVER"] = @server

    # Run multiple generators in sequence
    say "Running generator: add_capistrano_gems"
    generate "add_capistrano_gems"

    # Run bundle install
    say "Running: bundle installs"
    run "bundle install --platform=x86_64-linux"
    run "bundle install"

    # Ask for confirmation before running cap install with the given environment
    confirmation = ask("Do you want to run 'cap install STAGES=#{@env}'? (yes/no)", default: "yes")

    if confirmation.downcase == "yes"
      say "Running: cap install STAGES=#{@env}"
      run "cap install STAGES=#{@env}"
    else
      say "Skipping 'cap install STAGES=#{@env}'", :yellow
    end

    # Run the remaining generators
    say "Running generator: replace_capfile"
    generate "replace_capfile"

    say "Running generator: replace_deploy"
    generate "replace_deploy"

    say "Running generator: setup_prerequisite"
    generate "setup_prerequisite"

    say "All generators have been run successfully!"
  rescue => e
    say "An error occurred: #{e.message}", :red
  end
end
