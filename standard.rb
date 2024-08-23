# frozen_string_literal: true

def rubocop
  # file ".rubocop.yml", open("../rails_templates/.rubocop.yml") { |f| f.read }
  file ".rubocop.yml", URI.open("https://raw.githubusercontent.com/leightonj/rails_templates/main/.rubocop.yml", &:read)
  git add: ".rubocop.yml"
  git commit: "-am 'rubocop'"
end

after_bundle do
  generate("rspec:install")
  generate("simple_form:install")

  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
  rubocop
  # pp run("rubocop -A")
end

gem "aasm"
gem "faker"
gem "simple_form"
gem "timecop"

gem_group :development, :test do
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rubocop-factory_bot", require: false
  gem "rubocop-rails"
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
end

# rails_helper.rb
# RSpec.configure do |config|
#   config.include FactoryBot::Syntax::Methods
# end
