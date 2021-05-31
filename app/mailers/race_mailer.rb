class RaceMailer < ApplicationMailer
  default from: 'noreply@virtualdash.co'

  def position_change_email
    @user = params[:user]
    @race = params[:race]
    @place = params[:place]

    mail(
      to: @user[:email],
      subject: "Your position on #{@race[:title]} has changed"
    )
  end
end
