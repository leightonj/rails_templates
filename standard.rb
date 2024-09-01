# frozen_string_literal: true

def setup_rubocop
  file ".rubocop.yml", open("../rails_templates/.rubocop.yml", &:read)
  # uri = "https://raw.githubusercontent.com/leightonj/rails_templates/main/.rubocop.yml"
  # file ".rubocop.yml", URI.open(uri, &:read)
  git add: ".rubocop.yml"
  git commit: "-q -m 'rubocop'"
end

def setup_rspec
  generate("rspec:install")
  git add: ".rspec spec"
  git commit: "-q -m 'rspec'"
end

def setup_simple_form
  run("bundle add simple_form")
  generate("simple_form:install --bootstrap")
  git add: "config/initializers/simple_form.rb config/locales/simple_form.en.yml lib/templates"
  git commit: "-q -m 'simple_form'"
end

def setup_user
  generate(:scaffold, "user", "first_name:string{50}", "last_name:string{50}", "deleted_at:datetime")
  rails_command "db:migrate"
  git add: "."
  git commit: "-am 'User scaffold'"
end

def setup_cancancan
  generate("cancan:ability")
  git add: "app/models/ability.rb"
  git commit: "-q -m 'cancancan'"
end

def setup_delayed_job
  generate("delayed_job:active_record")
  rails_command "db:migrate"
  git add: "bin/delayed_job db/migrate db/schema.rb"
  git commit: "-m 'delayed_job'"
end

def setup_whenever
  run("wheneverize")
  git add: "config/schedule.rb"
  git commit: "-q -m 'whenever'"
end

def setup_devise
  generate("devise:install")
  generate("devise:views")
  generate(:devise, "User")
  rails_command "db:migrate"

  rm_and_copy_file("db/seeds.rb")
  rails_command "db:seed"

  git add: "."
  git commit: "-q -m 'devise and seeds'"
end

def clean_gemfile
  run("rm Gemfile")
  file "Gemfile", open("../rails_templates/Gemfile_clean", &:read)
  # file "Gemfile", URI.open("https://raw.githubusercontent.com/leightonj/rails_templates/main/Gemfile", &:read)
  git add: "Gemfile"
  git commit: "-q -m 'clean_gemfile'"
end

def setup_templates
  dir = "lib/templates/rails/scaffold_controller"
  FileUtils.mkdir_p(dir)
  fname = "#{dir}/controller.rb.tt"
  file fname, open("../rails_templates/#{fname}", &:read)
  # file "Gemfile", URI.open("https://raw.githubusercontent.com/leightonj/rails_templates/main/#{fname}", &:read)
  git add: fname
  git commit: "-q -m 'updated templates'"
end

def setup_locale
  fname = "config/locales/en.yml"
  rm_and_copy_file(fname)
  git add: fname
  git commit: "-q -m 'updated locale'"
end

def copy_concerns
  FileUtils.cp_r(Dir["../rails_templates/app/models/concerns/*"], "app/models/concerns")
  git add: "app/models/concerns"
  git commit: "-q -m 'added concerns'"
end

def setup_layout
  rm_and_copy_file("app/views/layouts/application.html.erb")
  copy_file("app/assets/stylesheets/main.css")
  FileUtils.mkdir_p("app/views/application/")
  copy_file("app/views/application/_card.html.erb")
  copy_file("app/views/application/_footer.html.erb")
  copy_file("app/views/application/_header.html.erb")

  git add: "app/views/layouts/application.html.erb app/assets/stylesheets/main.css app/views/application"
  git commit: "-q -m 'added a layout'"
end

def rm_and_copy_file(fname)
  run("rm #{fname}")
  copy_file(fname)
end

def copy_file(fname)
  file fname, open("../rails_templates/#{fname}", &:read)
  # file "Gemfile", URI.open("https://raw.githubusercontent.com/leightonj/rails_templates/main/#{fname}", &:read)
end

after_bundle do
  rails_command "db:drop"
  rails_command "db:create"

  git add: "."
  git commit: "-q -am 'Initial commit'"

  setup_rspec
  setup_simple_form
  setup_templates
  setup_locale
  setup_user
  setup_cancancan
  setup_delayed_job
  setup_whenever
  setup_devise
  copy_concerns
  setup_layout

  setup_rubocop
  # clean_gemfile

  # pp run("rubocop -A")
  # https://getbootstrap.com/
end

gem "aasm"
gem "cancancan"
# gem "dalli"
gem "delayed_job_active_record"
gem "devise"
gem "faker"
gem "faraday"
gem "jb"
# gem "rollbar"
# gem "slim-rails"
gem "timecop"
gem "view_component"
gem "whenever", require: false

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

# config/environments/development.rb
# config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

# app/views/layouts/application.html.erb
# <p class="notice"><%= notice %></p>
# <p class="alert"><%= alert %></p>
