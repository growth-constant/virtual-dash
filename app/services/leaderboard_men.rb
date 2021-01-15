# frozen_string_literal: true

# Service for LeaderboardMen
class LeaderboardMen
  def initialize(race)
    @race = race
  end

  def call
    {
      total_purse: total_purse,
      competitors: @race.race_tries.leaders_men,
      first_time: @race&.race_tries&.leaders_men&.first&.duration,
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
