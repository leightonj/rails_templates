# frozen_string_literal: true

user = User.find_or_initialize_by(email: "admin@project.com")
user.update!(first_name: "System", last_name: "Admin", password: "Flop-Hydroxide-Napped5")

project = Project.find_or_initialize_by(title: "Test project")
project.update!(creator: user, description: "this is my first project")
