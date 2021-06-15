class RacesEndedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    RacesEnded.new.call
  end
end
