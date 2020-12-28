class RegistrationController < ApplicationController
  before_action :set_race, only: [:create, :new]
  before_action :authenticate_user!

  def new
    puts params
    @registration = Registration.new(:user => current_user, :race => @race)
    authorize @registration, :create?
    # create stripe session for checkout
    product_name = "registration - #{@race.name} - #{@race.id}"
    price = (@race.price == 0.0 ? 10.0 : @race.price) * 100
    price = price.to_i
    puts "#{price} - #{product_name}"
    @stripe_session = Stripe::Checkout::Session.create({
      success_url: race_registration_index_url(@race),
      cancel_url: new_race_registration_url(@race),
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: product_name,
          },
          unit_amount: price
        },
        quantity: 1
      }],
      mode: 'payment',
    })
  end

  def create
    puts params
    # TODO check success parameters to make sure payment was made correctly
    @registration = Registration.new(:user => current_user, :race => @race)
    authorize @registration, :create?
    # save the registration in the DB
    respond_to do |format|
      if @registration.save
        format.html { redirect_to @race, notice: 'Successfully Registered to Race' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:race_id])
    end
end
