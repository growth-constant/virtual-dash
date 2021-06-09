# frozen_string_literal: true

# Registration activerecord model
class Registration < ApplicationRecord
  extend Enumerize
  belongs_to :race
  belongs_to :user

  enumerize :status, in: [
    :require_agreements,
    :require_payment,
    :awaiting_payment_confirmation,
    :registered
  ], default: :require_agreements
  enumerize :payment_status, in: [
    :paid,
    :unpaid,
    :no_payment_required
  ], default: :unpaid

  # Scopes
  scope :race_registration, lambda { |user, race|
    where(user_id: user.id, race_id: race.id).first
  }

  scope :user_registered_and_paid?, lambda { |user, race|
    where(user_id: user.id,
          race_id: race.id,
          status: :registered,
          payment_status: :paid)
  }

  scope :valid_to_collect_tries, lambda { |user|
    joins('INNER JOIN races ON registrations.race_id = races.id')
    .where("
      registrations.user_id = ?
      AND registrations.status = 'registered'
      AND registrations.payment_status = 'paid'
      AND races.enddate >= CURRENT_DATE
    ", user.id)
  }
end
