# CapistranoQuick

Capistrano is a powerful deployment automation tool for Ruby on Rails applications. In this guide, we’ll set up Capistrano with Puma on an AWS EC2 instance to deploy a Rails application smoothly.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add capistrano_quick
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install capistrano_quick
```

## Usage

```bash
rails generate setup_deployment
MODE=once cap production deployment
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
