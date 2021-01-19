# frozen_string_literal: true

# Service for Leaderboard
class Leaderboard
  def initialize(race, limit = 3)
    @race = race
    @limit = limit
  end

  def call
    {
      total_purse: total_purse,
      competitors: competitors,
      first_time: @race&.race_tries&.leaders&.first&.duration,
      tries_counter: @race&.race_tries&.count,
      prizes: {
        first: (total_purse / 2).to_i,
        second: (total_purse / 3).to_i,
        third: (total_purse / 6).to_i
      }
    }
  end

  private

  def competitors
    @limit == :all ? @race.race_tries.leaders : @race.race_tries.leaders.limit(@limit)
  end

  def total_purse
    @race.total_purse
  end
end
