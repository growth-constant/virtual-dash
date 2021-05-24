require 'spec_helper'

describe CollectTriesJob do

  # time = DateTime.now.change({ hour: 23, min: 59 })
  
  it 'runs without errors' do
    assert_silent  { CollectTriesJob.perform_now() }
  end

end