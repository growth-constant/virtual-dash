class RaceMailer < ApplicationMailer
  default from: 'noreply@virtualdash.co'

  def position_change_email
    @user = params[:user]
    @race = params[:race]
    @place = params[:place]

    attachments.inline['v-logo.svg'] = File.read('app/assets/images/logos/vertical-logo.svg')

    mail(
      to: @user[:email],
      subject: "Your position on #{@race[:title]} has changed"
    )
  end
  
  def race_ended_email
    @user = params[:user]
    @race = params[:race]
    @place = params[:place]
    
    attachments.inline['v-logo.svg'] = File.read('app/assets/images/logos/vertical-logo.svg')

    mail(
      to: @user[:email],
      subject: "#{@race[:title]} has ended"
    )
  end
end
