# frozen_string_literal: true

user = User.find_or_initialize_by(email: "admin@project.com")
user.update!(first_name: "System", last_name: "Admin", password: "Flop-Hydroxide-Napped5")
