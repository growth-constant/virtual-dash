# frozen_string_literal: true

# class RaceTry
class RaceTry < ApplicationRecord
  belongs_to :registration
  belongs_to :user

  default_scope { order(start: :desc) }
end
