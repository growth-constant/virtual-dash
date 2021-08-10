require 'stripe'

module StripePayout

  def transfer_prize_to_user(prize)
    # TODO: Get list of prizes (?
    # TODO: Get prize with user and race
    if prize.user.stripe_conn_acc_id
      make_transfer(prize)
    end
  end

  def make_transfer(prize)
    transfer = Stripe::Transfer.create({
      amount: prize.amount,
      currency: prize.currency,
      destination: prize.user.stripe_conn_acc_id,
      description: 'Virtual Dash Prize',
    })

    prize.update(stripe_transfer_id: transfer.id)
  end

end