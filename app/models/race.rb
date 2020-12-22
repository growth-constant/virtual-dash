class Race < ApplicationRecord
  has_many :race_tries
  after_create :update_race

  private

  def update_race
    RaceSegment.new(self, User.current).call
  end
end
