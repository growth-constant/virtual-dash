# frozen_string_literal: true

# Race activerecord model
class Race < ApplicationRecord
  paginates_per 10

  belongs_to :user
  has_many :race_tries
  has_many :registrations
  after_create :update_race

  # Scopes
  scope :search, ->(params) { 
    query_string = []

    params.each do |name, value|
      case name
      when 'name'
        if value != ''
          query_string.push("title ILIKE '%#{value}%' OR description ILIKE '%#{value}%'")
        end
      when 'time'
        if value == 'current'
          query_string.push('startdate <= NOW()::timestamp AND enddate >= NOW()::timestamp')
        elsif value == 'upcoming'
          query_string.push('startdate >= NOW()::timestamp AND enddate >= NOW()::timestamp')
        end
      when 'distance'
        if value != ''
          query_string.push("distance <= #{value}")
        end
      end
    end

    where(query_string.join(' AND '))
  }

  def total_purse
    # If there's no price set on the DB, default price will be 10 USD
    checked_price = (price == 0) ? 10 : price 
    ((checked_price * registrations&.count) * 0.9).to_i
  end

  private

  def update_race
    RetrieveSegmentInfoJob.perform_now(self, User.current)
  end
end
