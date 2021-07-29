require 'stripe'

module StripeConnectHelper

  def create_stripe_connect_account(user)
    # TODO: Explain to user what to put on the website field
    if user.stripe_conn_acc_id.nil?
      connected_acc = create_connect_account(user)
      add_stripe_conn_acc_id(user, connected_acc.id)
    end
    
    linked_acc = create_linked_account(user)
  end

  def delete_stripe_connect_account(user, acc_id)
    if acc_id == user.stripe_conn_acc_id
      account = Stripe::Account.delete(user.stripe_conn_acc_id)
      
      if account.deleted
        user.update(stripe_conn_acc_id: nil)
      end
    end
  end

  private

  def create_connect_account(user)
    account = Stripe::Account.create({
      email: user.email,
      type: 'express',
      country: 'US', # TODO: Make clear on help page that this is US only
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
      }
    })
  end

  def create_linked_account(user)
    account_links = Stripe::AccountLink.create({
      type: 'account_onboarding',
      account: user.stripe_conn_acc_id,
      return_url: 'https://' + ENV['RAILS_HOST'] + '/activity?stripe_connect=return',
      refresh_url: 'https://' + ENV['RAILS_HOST'] + "/activity?stripe_connect=refresh&acc_id=#{user.stripe_conn_acc_id}",
    })
  end

  def add_stripe_conn_acc_id(user, stripe_conn_acc_id)
    user.update(stripe_conn_acc_id: stripe_conn_acc_id)
  end

end