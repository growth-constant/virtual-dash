class RaceMailer < ApplicationMailer
  default from: 'noreply@growthconstant.com'

  def position_change_email
    mail(
      to: "angel-ortega12@hotmail.com",
      subject: "Your position on Lola's Walk has changed"
    )
  end
end
