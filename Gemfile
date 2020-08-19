# frozen_string_literal: true

source "https://rubygems.org"
gemspec
rails_version = "#{ENV['GEMFILE_RAILS_VERSION'] || '4.2.11.1'}"

gem "capybara", "~> 2.13.0"
gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
gem 'sprockets', '3.7.2'