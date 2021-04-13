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
        
        @date_leaderboard.each_with_index do | race_try, index |
          if race_try.user_id == @me.id
            @position_log.push(
              position: index,
              date: race_try.start,
              race_try_id: race_try.id
            )
          end
        end

      end
    end

    @position_log = @position_log.uniq { |log| log[:race_try_id]}
  end

end