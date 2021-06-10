class RacesEnded

  def initialize
    @thingy = Race.user_data_from_ended_race
  end

  def call
    notify
  end

  def notify
    @thingy.each do | thing |
      user = {
        :id => thing[:user_id],
        :email => thing[:email],
        :first_name => thing[:first_name]
      }

      race = {
        :id => thing[:race_id],
        :title => thing[:title],
        :enddate => thing[:enddate],
        :startdate => thing[:startdate],
      }

      leaderboard = Leaderboard.new(race, :all).call
      place = leaderboard.index(leaderboard.find { |try| try[:id] === user[:id] })

      RaceMailer.with(
        user: user,
        race: race,
        place: (place + 1).ordinalize
      ).race_ended_email.deliver_now
    end
  end

end