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
end
