class UserRegisterStripeJob < ApplicationJob
  queue_as :stripe

  def perform(user)
    email = user.email
    name = "#{user.first_name} #{user.last_name} "
    description = "#{user.id}"
    # create the stripe customer and store it's id on user
    stripe_customer = Stripe::Customer.create({
      email: email,
      name: name,
      description: description 
    })
    user.stripe_customer_id = stripe_customer.id
    user.save
  end
end
