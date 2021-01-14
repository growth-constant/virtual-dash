# frozen_string_literal: true

# class RaceTry
class RaceTry < ApplicationRecord
  belongs_to :registration
  belongs_to :user

  # Scopes
  scope :leaders, -> { select('name as name, image_medium as image, MIN(duration) as duration').joins(:user).group(:user_id, :name, :image_medium).order(3)}
end
