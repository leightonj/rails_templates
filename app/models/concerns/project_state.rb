# frozen_string_literal: true

# Project state machine
module ProjectState
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: "status", timestamps: true do
      state :new, initial: true
      state :in_progress, :in_review, :completed

      event :start do
        transitions from: :new, to: :in_progress
      end

      event :review do
        transitions from: :in_progress, to: :in_review
      end

      event :complete do
        transitions from: %i[in_progress in_review], to: :completed
      end

      event :reset do
        transitions from: %i[in_progress in_review completed], to: :new
        after do
          self.in_progress_at = nil
          self.in_review_at = nil
          self.completed_at = nil
          save!
        end
      end
    end
  end
end
