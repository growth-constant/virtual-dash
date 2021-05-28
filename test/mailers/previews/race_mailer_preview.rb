# Preview all emails at http://localhost:3000/rails/mailers/race_mailer
class RaceMailerPreview < ActionMailer::Preview
  def position_change_email
    RaceMailer.position_change_email
  end
end
