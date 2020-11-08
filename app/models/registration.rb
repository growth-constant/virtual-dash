class Registration < ApplicationRecord
  belongs_to :race
  belongs_to :user
  belongs_to :race_category
end
