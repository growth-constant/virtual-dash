require 'stripe'

module StripeConnectHelper

  def create_stripe_connect_account(user)
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

  def create_stripe_dashboard_link(user)
    if user.stripe_conn_acc_id
      login_link = Stripe::Account.create_login_link(user.stripe_conn_acc_id)
      login_link.url
    end
  end

  def get_stripe_user_balance(user)
    if user.stripe_conn_acc_id
      account = Stripe::Balance.retrieve({
        stripe_account: user.stripe_conn_acc_id
      })
      
      # Handle the case where the user has no balance
      if account.available[0]
        # Stripe returns balance in cents
        account.available[0].amount.to_f / 100
      else
        'N/A'
      end
    end
  end

  private

  def create_connect_account(user)
    account = Stripe::Account.create({
      email: user.email,
      type: 'express',
      country: 'US',
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
