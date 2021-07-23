
module StripeConnectHelper

  def create_connect_account(user)
    account = Stripe::Account.create({
      type: 'express'
    })
  end

  def create_linked_account(user)
    account_links = Stripe::AccountLink.create({
      account: user.stripe_account_id,
      refresh_url: 'https://example.com/reauth',
      return_url: 'https://example.com/return',
      type: 'account_onboarding',
    })
  end

end

# TODO:
# - Check all data that is returned from Stripe.
# - Make a migtration with the new data structure.
# - Connect the user to the stripe account.
# - Create return url.
# - Create refresh url.
# - Create a new stripe linked account for the user.