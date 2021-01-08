class RetrieveSegmentInfoJob < ApplicationJob
  queue_as :default

  def perform(race, user)
    RaceSegment.new(race, user).call
  end
end
