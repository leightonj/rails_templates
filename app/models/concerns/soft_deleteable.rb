# frozen_string_literal: true

# concern to soft delete a model
module SoftDeleteable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted_at: nil) }
  end

  def destroy
    update!(deleted_at: Time.current)
    # self.class._all_dependents.each do |association|
    #   next unless association.try(:dependent) == :destroy

    #   send(association.name).each(&:destroy)
    # end
  end
end
