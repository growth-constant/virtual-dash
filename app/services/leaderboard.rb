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

  def self.get_prize_amount(leaderboard, user_id)
    prize = 0
    leaderboard[:competitors].each_with_index do |competitor, index|
      if competitor.id == user_id 
        case index
        when 0
          prize = leaderboard[:prizes][:first]
        when 1
          prize = leaderboard[:prizes][:second]
        when 2
          prize = leaderboard[:prizes][:third]
        else
          prize = 0
        end
      end
    end
    prize
  end

  private

  def competitors
    @limit == :all ? RaceTry.leaders(@race, 10000) : RaceTry.leaders(@race, 3)
  end

  def users_tries
    @users_tries = RaceTry.tries_per_user(@race)
  end

  def total_purse
    @race.total_purse
  end
end
