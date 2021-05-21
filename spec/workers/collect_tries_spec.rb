require 'spec_helper'

describe CollectTriesJob do

  time = (Time.zone.today + 6.hours).to_datetime
  scheduled_job = described_class.perform_in(time, 'CollectTriesJob', true)

  it "the truth" do
    assert true
  end

  it 'occurs at expected time' do
    scheduled_job
    assert_equal true, described_class.jobs.last['jid'].include?(scheduled_job)
    expect(described_class).to have_enqueued_sidekiq_job('CollectTriesJob', true)
  end

end