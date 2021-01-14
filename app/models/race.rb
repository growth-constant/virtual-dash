# frozen_string_literal: true

# Race activerecord model
class Race < ApplicationRecord
  paginates_per 2

  belongs_to :user
  has_many :race_tries
  after_create :update_race

  # Scopes
  scope :search, ->(q) { where(['title ILIKE ? OR description ILIKE ? ', "%#{q}%", "%#{q}%"]) }

  private

  def update_race
    RetrieveSegmentInfoJob.perform_now(self, User.current)
  end
end
