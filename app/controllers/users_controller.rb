class UsersController < ApplicationController
  before_action :set_user
  before_action :get_stripe_data, only: %i[activity]

  def edit
  end

  def update
    respond_to do |format|
      if invalid_email?
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif @user.update(user_params)
        profile_complete
        format.html { redirect_to races_path, notice: 'Race was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def activity
    @race_name = params[:name] ? "%#{params[:name]}%" : '%%'
    races = Race.registrations_paid(current_user, @race_name)
    @activities = []

    if params[:stripe_connect] == 'return'
      flash[:notice] = 'Stripe account linked!'
    elsif params[:stripe_connect] == 'refresh'
      helpers.delete_stripe_connect_account(current_user, params[:acc_id])
      flash[:alert] = 'Something happen linking your Stripe account, please try again!'
    end
    
    races.each do | race |
      if race.enddate <= DateTime.now
        leaderboard = Leaderboard.new(race, :leaders).call
        place = leaderboard[:competitors].index(leaderboard[:competitors].find { |try| try[:id] == current_user[:id] })

        unless place.nil?
          case place
          when 0
            prize = leaderboard[:prizes][:first]
          when 1
            prize = leaderboard[:prizes][:second]
          when 2
            prize = leaderboard[:prizes][:third]
          else
            prize = 0
          end
  
          @activities.push({
            :date => race.enddate,
            :description => "#{(place + 1).ordinalize} place prize - #{race.title}",
            :amount => prize
          })
        end
      end
      
      @activities.push({
        :date => race.registrations.first.updated_at,
        :description => "Race registration - #{race.title}",
        :amount => (race.price > 0) ? -race.price : -10
      })
    end
  end

  def create_connect_account
    linked_account = helpers.create_stripe_connect_account(current_user)
    redirect_to linked_account.url
  end

  private

  def set_user
    @user = current_user
  end

  def invalid_email?
    params['user']['email'].include? '@autogenerated.com'
  end


  def profile_complete
    u = current_user
    complete = (!u.name.nil? && u.name != '') \
               && (!u.birthdate.nil? &&  u.birthdate != '') \
               && (!u.gender.nil? && u.gender != '') \
               && (!u.phone.nil?  && u.phone != '') ? true : false

    u.update(profile_complete: true) if complete
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:id, :gender, :phone, :profile_complete, :name, :birthdate, :email)
  end

  def get_stripe_data
    if current_user.stripe_conn_acc_id
      @dashboard = helpers.create_stripe_dashboard_link(current_user)
      @balance = helpers.get_stripe_user_balance(current_user)
    end
  end

end
