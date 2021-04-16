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
    RaceTry.user_segments(@me.id, @leaderboard[:race_segment])
  end

end