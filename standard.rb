after_bundle do
  generate("rspec:install")

  # git :init
  # git add: "."
  # git commit: %Q{ -m 'Initial commit' }

  file ".rubocop.yml", open("../rails_templates/.rubocop.yml") { |f| f.read }
  # file ".rubocop.yml", URI.open("https://raw.githubusercontent.com/leightonj/rails_templates/main/.rubocop.yml") { |f| f.read }
  run("rubocop -A")
end

gem_group :development, :test do
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
end
