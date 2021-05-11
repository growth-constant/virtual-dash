class RacesController < ApplicationController
  before_action :set_race, only: %i[show edit update destroy leaderboard general_classification personal]
  before_action :set_profile, only: %i[index]
  before_action :registered, only: %i[show leaderboard]
  before_action :filter, only: %i[index]

  def index; end

  def leaderboard
    @leaderboard = Leaderboard.new(@race).call

    # For when categories comes to life
    # @leaderboard_men = MenLeaderboard.new(@race, competitors_qty).call
    # @leaderboard_women = WomenLeaderboard.new(@race, competitors_qty).call
  end

  def general_classification
    @results = Leaderboard.new(@race, :all).call
    @competitors = Kaminari.paginate_array(@results[:competitors]).page(params[:page]).per(1)
  end

  def personal
    @leaderboard = Leaderboard.new(@race, :all).call
    @personal =  PersonalLeaderboard.new(@leaderboard, current_user).call
  end

  def show
    coordinates = Polylines::Decoder.decode_polyline(@race.all_data['map']['polyline'])
    i = coordinates.size / 2
    @lat = coordinates[i][0]
    @lng = coordinates[i][1]
    @leaderboard = Leaderboard.new(@race).call
    check_payment_status(@race)
  end

  def new
    @race = Race.new
    authorize @race, :create?
  end

  def edit
    authorize @race, :edit?
  end

  def create
    @race = Race.new(race_params)
    @race.user_id = current_user.id

    respond_to do |format|
      if @race.save
        CollectTries.new.call # Collect new tries after a new race is crated
        format.html { redirect_to @race, notice: 'Race was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @race.update(race_params)
        format.html { redirect_to @race, notice: 'Race was successfully updated.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url, notice: 'Race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def filter
    # When paginator is implemented, change the 3 for 4 in the conditional
    if params.as_json.size < 3
      @races = Race.all.page(params[:page])
    else
      @params = params.as_json
      @races = Race.search(@params).page(params[:page])
    end
  end

  def registered
    return unless current_user

    @registered = Registration.user_registered_and_paid?(current_user, @race)
  end

  def check_payment_status(race)
    registration = Registration.race_registration(current_user, race)
    if registration.status == 'require_payment'
      stripe_res = Stripe::Checkout::Session.retrieve(
        registration.session_id
      )
      if stripe_res.payment_status == 'paid'
        registration.update(
          status: 'registered',
          payment_status: 'paid'
        )
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_race
    @race = Race.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def race_params
    params.require(:race).permit(:title, :description, :country, :state, :city, :enddate, :segment_id, :user_id)
  end
end
