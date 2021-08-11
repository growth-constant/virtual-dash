require 'stripe'

class StripePayout

  def initialize(race)
      @prizes = Prize.prizes_from_race(race)
  end

  def call
    @prizes.each do | prize |
      transfer_prize_to_user(prize)
    end
  end

  private

  def transfer_prize_to_user(prize)
    # Only transfer to users with a Connected Account
    if prize.user.stripe_conn_acc_id
      transfer = Stripe::Transfer.create({
        amount: prize.amount,
        currency: prize.currency,
        destination: prize.user.stripe_conn_acc_id,
        description: 'Virtual Dash Prize',
      })

      # Save the transfer ID in the prize
      prize.update(stripe_transfer_id: transfer.id)
    end
  end

end