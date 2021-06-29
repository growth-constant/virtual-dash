
class HomeController < ApplicationController
  def secret
  end

  def index
  end

  def about
  end

  def help
    @content = [
      {
        :title => 'Getting started',
        :elements => [
          {:title => 'Registering with Strava', :content => 'Lorem'},
          {:title => 'Account creation', :content => 'Lorem'},
          {:title => 'Races and segments', :content => 'Lorem'},
          {:title => 'Registering to a race', :content => 'Lorem'},
        ]
      }
    ]
  end

end
