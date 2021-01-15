# frozen_string_literal: true

# Service for MenLeaderboard
class MenLeaderboard
  def initialize(race, limit)
    @race = race
    @limit = limit
  end

  def call
    {
      total_purse: total_purse,
      competitors: @race.race_tries.leaders_men.limit(@limit),
      first_time: @race&.race_tries&.leaders_men&.first&.duration,
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
