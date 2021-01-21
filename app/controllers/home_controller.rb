class HomeController < ApplicationController
  layout 'home'

  def index
    @races = Race.all.page(params[:page])
  end

  def secret; end
end
