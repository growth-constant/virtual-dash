class Race < ApplicationRecord
  has_many :race_tries
  after_create :update_race

  private

  def update_race
    RetrieveSegmentInfoJob.perform_now(self, User.current)
  end
end
