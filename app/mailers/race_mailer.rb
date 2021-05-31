class RaceMailer < ApplicationMailer
  default from: 'noreply@virtualdash.co'

  def position_change_email
    @user = {
      :first_name => 'Layton',
      :email => 'andre@thetail.xyz'
    }
    @race = {
      :id => 1,
      :title => 'Snowpiercer'
    }
    @place = '3rd'
    mail(
      to: @user[:email],
      subject: "Your position on #{@race[:title]} has changed"
    )
  end
end
