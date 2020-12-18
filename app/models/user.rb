class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[strava]

  has_many :race_tries

  def self.from_omniauth_to_fields(auth)
    fields = {}
    if not auth.is_a?(OmniAuth::AuthHash)
      auth = OmniAuth::AuthHash.new(auth)
    end
    raw_info = auth.extra.raw_info
    # personal info
    fields[:name] = auth.info.name
    fields[:first_name] = raw_info.firstname
    fields[:last_name] = raw_info.lastname
    fields[:image] = raw_info.profile
    fields[:image_medium] = raw_info.profile_medium
    fields[:city] = raw_info.city
    fields[:state] = raw_info.state
    fields[:country] = raw_info.country
    # provider
    fields[:provider] = auth.provider
    fields[:uid] = auth.extra.raw_info.id
    # credentials
    fields[:token] = auth.credentials.token
    fields[:token_expires_at] = auth.credentials.expires_at
    fields[:refresh_token] = auth.credentials.refresh_token
    return fields
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      fields = self.from_omniauth_to_fields(auth)
      # if email is null then get it from the user
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      fields.each do |field, value|
        user.attributes[field] = value
      end
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
