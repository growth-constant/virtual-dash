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
    dates = RaceTry.segment_dates(@leaderboard[:race_segment])
    segments = []

    dates.each_with_index do | date, index |
      tries = RaceTry.tries_between_dates(
        @leaderboard[:race_segment],
        dates.first[:start],
        date[:start]
      ).to_a
      position = get_position(tries)
      my_tries = tries_on_date(tries, date[:start])

      segments.push({
        date: date[:start],
        tries: my_tries,
        position: position
      })
    end
    puts segments
  end

  def get_position(tries)
    tries = tries.sort_by! { |try| try[:duration] }
    tries.index { |try| try[:user_id] == @me.id }.min
  end

  def tries_on_date(tries, date)
    tries.select{ |try| try[:start] == date && try[:user_id] == @me.id }
  end

end