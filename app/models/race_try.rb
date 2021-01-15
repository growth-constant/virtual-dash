# frozen_string_literal: true

# class RaceTry
class RaceTry < ApplicationRecord
  belongs_to :registration
  belongs_to :user

  # Scopes
  scope :leaders, lambda {
    select('name as name, image_medium as image, MIN(duration) as duration')
      .joins(:user)
      .group(:user_id, :name, :image_medium)
      .order(3)
  }

  scope :leaders_men, lambda {
    select('name as name, image_medium as image, MIN(duration) as duration, gender')
      .joins(:user)
      .where('users.gender': 'male')
      .group(:user_id, :name, :image_medium, :gender)
      .order(3)
  }

  scope :leaders_women, lambda {
    select('name as name, image_medium as image, MIN(duration) as duration, gender')
      .joins(:user)
      .where('users.gender': 'female')
      .group(:user_id, :name, :image_medium, :gender)
      .order(3)
  }
end
