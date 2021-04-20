# frozen_string_literal: true

# Race activerecord model
class Race < ApplicationRecord
  paginates_per 10

  belongs_to :user
  has_many :race_tries
  has_many :registrations
  after_create :update_race

  # Scopes
  scope :search, ->(q) { where(['title ILIKE ? OR description ILIKE ? ', "%#{q}%", "%#{q}%"]) }

  def total_purse
    ((price * registrations&.count) * 0.9).to_i
  end

  private

  def update_race
    if User.current[:email] != 'mr.wilford@wilford.co'
      RetrieveSegmentInfoJob.perform_now(self, User.current)
    end
  end
end
