# frozen_string_literal: true

# concern for adding created by field to models
module CreatedBy
  extend ActiveSupport::Concern

  included do
    belongs_to :creator, class_name: "User", foreign_key: "created_by"
  end

  # private

  # def update_creator
  #   self.creator ||= User.current_user
  # end
end
