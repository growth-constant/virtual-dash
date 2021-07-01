require 'rails_helper'

RSpec.describe CollectTriesJob do

  it 'runs without errors' do
    assert_silent  { CollectTriesJob.perform_now() }
  end
  
  it 'runs at 23:59' do
    ActiveJob::Base.queue_adapter = :test
    time = DateTime.now.change({ hour: 23, min: 59 })

    expect {
      CollectTriesJob.set(:wait_util => time).perform_later
    }.to enqueue_job(CollectTriesJob)
  end
  
end