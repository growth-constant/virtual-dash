# Preview all emails at http://localhost:3000/rails/mailers/race_mailer
class RaceMailerPreview < ActionMailer::Preview
  def position_change_email
    user = {
      :first_name => 'Layton',
      :email => 'andre@thetail.xyz'
    }
    race = {
      :id => 1,
      :title => 'Snowpiercer'
    }
    place = '3rd'
    
    RaceMailer.with(user: user, race: race, place: place).position_change_email
  end
end
