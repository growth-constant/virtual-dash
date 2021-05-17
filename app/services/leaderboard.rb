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
      first_time: RaceTry.leaders(@race, 1)&.first&.duration,
      tries_counter: @race&.race_tries&.count,
      race_segment: @race.segment_id,
      users_tries: users_tries,
      prizes: {
        first: (total_purse / 2).to_i,
        second: (total_purse / 3).to_i,
        third: (total_purse / 6).to_i
      }
    }
  end

  private

  def competitors
    @limit == :all ? RaceTry.leaders(@race, 10000) : RaceTry.leaders(@race, 3)
  end

  def users_tries
    @users_tries = RaceTry.tries_per_user(@race)
    
    p '>>>><<<<<'
    try = @users_tries.select { |user| user[:user_id] == 1 }
    p try[0][:tries]

  end

  def total_purse
    @race.total_purse
  end
end
