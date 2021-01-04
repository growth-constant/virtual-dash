class RegistrationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_race, only: [:new]
  before_action :set_registration, only: [:checkout_successful, :checkout_session, :status]

  def new
    @registration = Registration.find_or_initialize_by(user: current_user, race: @race)
    if (not @registration.status.require_agreements?) and (not @registration.status.require_payment?)
      # redirect to correct page
      redirect_to @race, alert: "You are already registered"
    else
      authorize @registration, :new?
      @registration.save
    end
  end

  # POST /races/:race_id/registration/checkout_session
  def checkout_session
    # setup information for stripe session
    if @registration.session_id.present and @registration.session_id != ""
      render json: { id: @registration.session_id }
    end
    @race = @registration.race
    product_name = "registration - #{@race.name} - #{@race.id}"
    price = (@race.price == 0.0 ? 10.0 : @race.price) * 100
    price = price.to_i
    # get stripe session to checkout the registration to the race
    @stripe_session = Stripe::Checkout::Session.create({
      success_url: checkout_successful_race_registration_index_url(@race),
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
    @registration.session_id = @stripe_session.id
    @registration.agreements_signed = true
    @registration.status = :require_payment
    @registration.save!
    render json: { id: @stripe_session.id }
  end


  # GET /races/:race_id/registration/checkout_successful 
  def checkout_successful 
    # get session information and update registration accordingly
    byebug
    @race = @registration.race
    @stripe_session = Stripe::Checkout::Session.retrieve(@registration.session_id)
    @registration.payment_status = @stripe_session.payment_status
    if @registration.payment_status == :paid
      @registration.status = :registered
    else
      @registration.status = :awaiting_payment_confirmation
    end
    # save the registration in the DB
    respond_to do |format|
      if @registration.save
        format.html { redirect_to @race, notice: 'Successfully Registered to Race' }
      else
        render :status
      end
    end
  end

  def status
    @race = @registration.race
    authorize @registration, :status?
  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_registration
      @registration = Registration.find_by(race_id: params[:race_id], user: current_user)
    end
end
