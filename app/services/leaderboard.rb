# frozen_string_literal: true

# Service for Leaderboard
class Leaderboard
  def initialize(race, limit)
    @race = race
    @limit = limit
  end

  def call
    {
      total_purse: total_purse,
      competitors: @race.race_tries.leaders.limit(@limit),
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

  def total_purse
    @race.total_purse
  end
end
