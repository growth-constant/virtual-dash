# Users
wilford = User.find_by name: 'Joseph Wilford'
melanie = User.find_by name: 'Melanie Cavill'
layton = User.find_by name: 'Andre Layton'
josie = User.find_by name: 'Josie Wellstead'


# Races
snowpiercer_race = Race.find_by title: 'Snowpiercer'
big_alice_race = Race.find_by title: 'Big Alice Race'

# Registrations
Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: wilford,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'wilford-snowpiercer'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: melanie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'melanie-snowpiercer'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: layton,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'layton-snowpiercer'
)

Registration.find_or_create_by(
  race_id: snowpiercer_race,
  user_id: josie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'josie-snowpiercer'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: wilford,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'wilford-bigalice'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: melanie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'melanie-bigalice'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: layton,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'layton-bigalice'
)

Registration.find_or_create_by(
  race_id: big_alice_race,
  user_id: josie,
  status: 'registered',
  payment_status: 'paid',
  agreements_signed: true,
  session_id: 'josie-bigalice'
)