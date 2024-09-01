rails g scaffold Project created_by:integer title:string description:text num_comments:integer in_progress_at:datetime in_review_at:datetime completed_at:datetime deleted_at:datetime
# update locale notics
rails g aasm Project status
rails g scaffold Comment project:references created_by:integer text:text
# update locale notics

# app/models/project.rb
# belongs_to :creator, class_name: "User", foreign_key: :created_by, inverse_of: :projects
# scope :details, -> { select("projects.*, users.first_name").joins(:creator) }

# app/models/user.rb
# has_many :projects, inverse_of: :creator, dependent: :destroy

# db/seeds.rb
# project = Project.find_or_initialize_by(title: "Test project")
# project.update!(creator: user, description: "this is my first project")

# routes.rb
# resources :projects do
#   member do
#     get "event/:event" => "projects#event", as: :event
#   end
# end

# root "projects#index"

# <% #= turbo_frame_tag(id="device_status") do %>
#   <%= project.status.humanize %>
#   <% project.aasm.events.each do |event| %>
#     | <%= link_to event.to_s.humanize, event_project_path(project, event:) %>
#   <% end %>
# <% #end %>

# btn btn-primary
# btn btn-danger

# add comment - only update part of page
# tailwind
# slim
