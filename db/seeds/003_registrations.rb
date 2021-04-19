# Users
wilford = User.find(1)
melanie = User.find(2)
layton = User.find(3)
josie = User.find(4)


# Races
snowpiercer_race = Race.find(1)
big_alice_race = Race.find(2)

# Registrations
Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: wilford,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: melanie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: layton,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: josie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: wilford,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: melanie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: layton,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: josie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'cs_test_a1UufTYj3Tjc1qXYzKpl3qW4bPIoNaVTiNlTAvbLumegYo0MbcMY3BCAVQ'
)