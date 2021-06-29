module HomeHelper

  def get_help_content
    @content = [
      { 
        :title => 'Getting started',
        :elements => [
          {:title => 'Registering with Strava', :content => 'Lorem'},
          {:title => 'Account creation', :content => 'Lorem'},
          {:title => 'Races and segments', :content => 'Lorem'},
          {:title => 'Registering to a race', :content => 'Lorem'},
        ]
      },
      { 
        :title => 'Account management',
        :elements => [
          {:title => 'Account settings', :content => 'Lorem'},
          {:title => 'User verification', :content => 'Lorem'},
          {:title => 'Account recovery', :content => 'Lorem'},
        ]
      },
      { 
        :title => 'Prizes and payments',
        :elements => [
          {:title => 'Race course', :content => 'Lorem'},
          {:title => 'Standings and rankings', :content => 'Lorem'},
          {:title => 'Social network', :content => 'Lorem'},
        ]
      },
      { 
        :title => 'Competition and community',
        :elements => [
          {:title => 'Leaderboards', :content => 'Lorem'},
          {:title => 'Race course', :content => 'Lorem'},
          {:title => 'Standings and rankings', :content => 'Lorem'},
          {:title => 'Social network', :content => 'Lorem'},
        ]
      },
      { 
        :title => 'Race organization',
        :elements => [
          {:title => 'Creating a race', :content => 'Lorem'},
          {:title => 'Race administration', :content => 'Lorem'},
          {:title => 'Claiming race earnings', :content => 'Lorem'},
        ]
      },
      { 
        :title => 'Policy and safety',
        :elements => [
          {:title => 'Terms and conditions', :content => 'Lorem'},
          {:title => 'Privacy policy', :content => 'Lorem'},
          {:title => 'Cookies', :content => 'Lorem'},
        ]
      }
    ]
  end

end
