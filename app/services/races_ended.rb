class RacesEnded

  def initialize
    @ended_races = Race.user_data_from_ended_race
  end

  def call
    notify
  end

  def notify
    @ended_races.each do | race |
      leaderboard = Leaderboard.new(race, :all).call
      place = leaderboard.find { |try| try[:id] === race.user[:id] }

      p (place + 1).ordinalize
      # RaceMailer.with(
      #   race: race,
      #   user: race.user,
      #   place: (place + 1).ordinalize
      # ).race_ended_email.deliver_now
    end
  end

end