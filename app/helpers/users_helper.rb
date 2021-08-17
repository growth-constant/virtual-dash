module UsersHelper
  
  def handle_stripe_connect(params, user)
    if params[:stripe_connect] == 'return'
      deposit_unpaid_prizes(user) # Method in stripe_connect_helper.rb
      flash[:notice] = 'You have successfully linked your Virtual Dash Balance to your Stripe account.'
    elsif params[:stripe_connect] == 'refresh'
      delete_stripe_connect_account(user, params[:acc_id]) # Method in stripe_connect_helper.rb
      flash[:alert] = 'Something happen linking your Stripe account, please try again.'
    end
  end

  def get_activities_from_user(races, user)
    activities = []

    races.each do | race |
      prize = Prize.prize_from_user_race(current_user, race).first

      if race.enddate <= DateTime.now && prize
        activities.push({
          :status => prize[:stripe_transfer_id].nil? ? 'PENDING' : 'OK',
          :amount => prize.amount,
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

    
    activities
  end


end