# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectTries, type: :model do
  describe '#call' do
    let(:victor) { create(:user) }

    it 'get segment tries for users' do
      race_tries = CollectTries.new.call

      expect(race_tries.count).to eq(2)
    end
  end
end
