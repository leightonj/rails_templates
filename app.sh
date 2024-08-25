rm -rf blog
# TEMPLATE="rails_templates/standard.rb"
TEMPLATE="https://raw.githubusercontent.com/leightonj/rails_templates/main/standard.rb"
rails new blog --template=$TEMPLATE --database=postgresql --skip-test --skip-jbuilder --quiet
# --skip-javascript --skip-hotwire --skip-bundle

code blog
