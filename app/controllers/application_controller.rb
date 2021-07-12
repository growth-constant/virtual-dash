class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_current_user


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_profile
    if current_user
      redirect_to edit_user_path(current_user) unless current_user.profile_complete
    end
  end

  def default_url_options
    { host: ENV['RAILS_HOST'] || 'localhost:3000' }
  end

  private

  def set_current_user
    User.current = current_user
    user_is_subscribed
  end
  
  def user_is_subscribed
    if current_user
      UserIsSubscribed.new(current_user).call
    end
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
