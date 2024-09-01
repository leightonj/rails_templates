rm -rf project_app
TEMPLATE="rails_templates/standard.rb"
# TEMPLATE="https://raw.githubusercontent.com/leightonj/rails_templates/main/standard.rb"
rails new project_app --template=$TEMPLATE --database=postgresql --skip-test --skip-jbuilder --quiet
# --skip-javascript --skip-hotwire --skip-bundle

code project_app
