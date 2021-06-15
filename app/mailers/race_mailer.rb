class RaceMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  default from: 'Virtual Dash <noreply@virtualdash.co>'

  def position_change_email
    @user = params[:user]
    @race = params[:race]
    @place = params[:place]

    attachments.inline['v-logo.png'] = File.read('app/assets/images/mails/vertical-logo.png')

    mail(
      to: @user[:email],
      subject: "Your position on #{@race[:title]} has changed"
    )
  end
  
  def race_ended_email
    @user = params[:user]
    @race = params[:race]
    @place = params[:place]
    
    attachments.inline['v-logo.png'] = File.read('app/assets/images/mails/vertical-logo.png')
    
    case @place
    when '1st'
      attachments.inline['trophy.png'] = File.read('app/assets/images/mails/1st-place-icon.png')
    when '2nd'
      attachments.inline['trophy.png'] = File.read('app/assets/images/mails/2nd-place-icon.png')
    when '3rd'
      attachments.inline['trophy.png'] = File.read('app/assets/images/mails/3rd-place-icon.png')
    else
    end

    mail(
      to: @user[:email],
      subject: "#{@race[:title]} has ended"
    )
  end
end
