rails g scaffold Project title:string description:text num_comments:integer progress_at:datetime review_at:datetime completed_at:datetime created_by:integer deleted_at:datetime
rails g scaffold Comment project:references text:text

# tailwind
# slim

# seeds
# project = Project.find_or_initialize_by(title: "Test project")
# project.update!(creator: user, description: "this is my first project")


# add comment - only update part of page
