# frozen_string_literal: true

# Service for Personal Leaderboard
class PersonalLeaderboard
  def initialize(leaderboard, me)
    @leaderboard = leaderboard
    @me = me
  end

  def call
    @overall_ranking = overall_ranking + 1
    {
      overall_ranking: @overall_ranking,
      category_ranking: @overall_ranking, # Change when categories come to life
      current_prize: current_prize(@overall_ranking),
      segment_activity: segment_activity
    }
  end

  private

  def overall_ranking
    @leaderboard[:competitors].index{ |competitor| competitor.id == @me.id}
  end

  def current_prize(overall_ranking)
    case overall_ranking
      when 1
        @leaderboard[:prizes][:first]
      when 2
        @leaderboard[:prizes][:second]
      when 3
        @leaderboard[:prizes][:third]
      else
        0
    end
  end

  ### Steps to get segment activity ###
  # [/] 1 - Get the all user tries
  # [/] 2 - Cycle throught the array
  # [/] 3 - Get the date of i and i+1
  # [/] 2 - Get overall leaderboard between the dates
  # [] 3 - Save position on @position_log
  # [] 4 - Repeat until finish compleate the array
  def segment_activity
    @tries = RaceTry.user_segments(@me, @leaderboard[:race_segment])
    @position_log = []

    @tries.each_with_index do | try, index |
      if not @tries.to_a[index + 1].nil?
        @date_leaderboard = RaceTry.tries_between_dates(
          @leaderboard[:race_segment],
          try[:start],
          @tries.to_a[index + 1][:start]
        )
        @position_log.push(@date_leaderboard.index { |competitor| competitor.user_id == @me.id })
      end
    end

    puts "### POSITION LOG ###"
    puts @position_log
    puts "######"

  end

end