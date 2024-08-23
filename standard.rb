after_bundle do
  generate("rspec:install")
  # rails generate rspec:install
  # git :init
  # git add: "."
  # git commit: %Q{ -m 'Initial commit' }
end

gem_group :development, :test do
  gem "rspec-rails"
  gem "rubocop-rails"
end
