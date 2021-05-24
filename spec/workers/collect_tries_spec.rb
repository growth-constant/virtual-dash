require 'spec_helper'

describe CollectTriesJob do

  it 'runs without errors' do
    assert_silent  { CollectTriesJob.perform_now() }
  end
  
  it 'runs at 23:59' do
    time = DateTime.now.change({ hour: 23, min: 59 })
    CollectTriesJob.set(wait_util: time).perform_later()
    assert_enqueued_with(job: CollectTriesJob)
  end
  
end