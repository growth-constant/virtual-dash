class RacesEnded

  def initialize
    @ended_races = Race.user_data_from_ended_race
  end

  def call
    create_prize_items
    notify
  end

  def create_prize_items
    @ended_races.each do | race |
      Prize.create_race_prizes(race)
    end
  end

  def notify
    @ended_races.each do | race |
      leaderboard = Leaderboard.new(race, :all).call[:competitors]
      place =  leaderboard.index(leaderboard.find { |try| try[:id] == race.user[:id] })

      RaceMailer.with(
        race: race,
        user: race.user,
        place: (place + 1).ordinalize
      ).race_ended_email.deliver_now
    end
  end

end