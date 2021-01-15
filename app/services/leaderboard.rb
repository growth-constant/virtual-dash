# frozen_string_literal: true

# Service for Leaderboard
class Leaderboard
  def initialize(race)
    @race = race
  end

  def call
    {
      total_purse: total_purse,
      competitors: @race.race_tries.leaders,
      first_time: @race&.race_tries&.leaders&.first&.duration,
      tries_counter: @race&.race_tries&.count,
      overall: {
        first_prize: (total_purse / 2).to_i,
        second_prize: (total_purse / 3).to_i,
        third_prize: (total_purse / 6).to_i
      }
    }
  end

  private

  def total_purse
    @race.total_purse
  end
end
