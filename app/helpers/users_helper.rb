module UsersHelper
  
  def handle_stripe_connect(params, user)
    if params[:stripe_connect] == 'return'
      helpers.deposit_unpaid_prizes(user)
      flash[:notice] = 'You have successfully linked your Virtual Dash Balance to your Stripe account.'
    elsif params[:stripe_connect] == 'refresh'
      helpers.delete_stripe_connect_account(user, params[:acc_id])
      flash[:alert] = 'Something happen linking your Stripe account, please try again.'
    end
  end

  def get_activities_from_user(races, user)
    activities = []

    races.each do | race |
      prize = Prize.prize_from_user_race(current_user, race)
      p '>>>><<<<'
      p prize
      if race.enddate <= DateTime.now
        activities.push({
          :status => prize[:stripe_transfer_id].nil? ? 'PENDING' : 'OK',
          :amount => prize,
          :date => prize.created_at,
          :description => "Race prize - #{race.title}",
        })
      end
      
      activities.push({
        :status => 'OK',
        :date => race.registrations.first.updated_at,
        :description => "Race registration - #{race.title}",
        :amount => (race.price > 0) ? -race.price : -10
      })
    end
  end


end