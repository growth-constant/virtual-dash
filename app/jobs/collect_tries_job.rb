class CollectTriesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CollectTries.new.call
  end
end
