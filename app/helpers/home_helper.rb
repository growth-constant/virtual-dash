module HomeHelper

  def get_help_content
    @content = [
      { 
        :title => 'Getting started',
        :elements => [
          {:title => 'Registering with Strava', :content => "You can <a class='link-to-anchor' href='/users/sign_in'>log in and register</a> in Virtual Dash via Strava, if you don't have a Strava account <a class='link-to-anchor' href='https://www.strava.com/register/free'>create one for free.</a>"},
          {:title => 'Account creation', :content => "After registering in with Strava, we'll ask you for some basic information (email, name, gender, phone, birthday). This data is used to give you a better experience, but only the email is required to use Virtual Dash."},
          {:title => 'Races and segments', :content => "Races on Virtual Dash are managed by the segments on Strava. You can see the segments you have created <a class='link-to-anchor' href='https://www.strava.com/athlete/segments/created'>here</a>, for information on the segments of the races you've participated please contact the race organizer."},
          {:title => 'Registering to a race', :content => "To be able to register to any race, you need to be a <a class='link-to-anchor' href='https://www.strava.com/subscribe'>Strava subscriber</a>. For the moment, we don't offer the service to non-premium Strava users."},
        ]
      },
      { 
        :title => 'Account management',
        :elements => [
          {:title => 'Account settings', :content => "To edit your user data, go to My Profile section on the menu or click <a class='link-to-anchor' href='/users/edit'>here.</a>"},
          {:title => 'Account recovery', :content => "If you loose access to your Strava account, use their <a class='link-to-anchor' href='https://www.strava.com/account/recover'>password reset tool</a> to receive an email with the steps to regain access."},
        ]
      },
      { 
        :title => 'Prizes and payments',
        :elements => [
          {:title => 'Prices', :content => "The prices are calculated according to the number of the participants and the entry price. The more participants there are on a race, the bigger the price! <br> If you win a race, the team of Virtual Dash will contact you via email with instructions on how to receive the prize."},
          {:title => 'Claim your prices', :content => ""}
          {:title => 'Payment', :content => "Payments, such as the one needed to registry to a race, are done safely via Stripe. Virtual Dash doesn't store your card information. To learn more about Stripe click <a class='link-to-anchor' href='https://stripe.com/about'>here.</a>"},
        ]
      },
      { 
        :title => 'Race organization',
        :elements => [
          {:title => 'Creating a race', :content => "If you're interested on creating a race on Virtual Dash, please contact <a class='link-to-anchor' href='mailto:victor@growthconstant.com'>victor@growthconstant.com</a>."},
        ]
      },
      { 
        :title => 'Policy and safety',
        :elements => [
          {:title => 'Terms and conditions', :content => "You can read more about our terms <a class='link-to-anchor' href='/docs/terms-of-use.pdf'>here.</a>"},
          {:title => 'Privacy policy', :content => "You can read more about our privacy policy <a class='link-to-anchor' href='/docs/privacy-policy.pdf'>here.</a>"},
        ]
      }
    ]
  end

end
