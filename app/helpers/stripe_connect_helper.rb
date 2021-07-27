require 'stripe'

module StripeConnectHelper

  def thingy(user)
    connected_acc = create_connect_account(user)
    add_stripe_conn_acc_id(user, connected_acc.id)
    linked_acc = create_linked_account(user)
    redirect_to linked_acc.url
  end

  private

  def create_connect_account(user)
    account = Stripe::Account.create({
      email: user.email,
      type: 'express',
      country: user.country ? user.country : 'US',
      business_type: 'individual',
      individual: {
        first_name: user.first_name,
        last_name: user.last_name,
        gender: user.gender,
        email: user.email,
        phone: user.phone,
        address: {
          city: user.city,
          country: user.country,
        },
        dob: {
          day: user.birthdate.day,
          month: user.birthdate.month,
          year: user.birthdate.year,
        }
    })
  end

  def create_linked_account(user)
    account_links = Stripe::AccountLink.create({
      account: user.stripe_conn_acc_id,
      refresh_url: 'https://www.virtualdash.co/activity',
      return_url: 'https://www.virtualdash.co/activity',
      type: 'account_onboarding',
    })
  end

  def add_stripe_conn_acc_id(user, stripe_conn_acc_id)
    user.update(stripe_conn_acc_id: stripe_conn_acc_id)
  end

end