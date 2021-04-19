# Users
wilford = User.find_by name: 'Joseph Wilford'
melanie = User.find_by name: 'Melanie Cavill'
layton = User.find_by name: 'Andre Layton'
josie = User.find_by name: 'Josie Wellstead'

# Registrations
wilford_snowpiercer = Registration.find_by session_id: 'wilford-snowpiercer'
melanie_snowpiercer = Registration.find_by session_id: 'melanie-snowpiercer'
layton_snowpiercer = Registration.find_by session_id: 'layton-snowpiercer'
josie_snowpiercer = Registration.find_by session_id: 'josie-snowpiercer'
wilford_big_alice = Registration.find_by session_id: 'wilford-bigalice'
melanie_big_alice = Registration.find_by session_id: 'melanie-bigalice'
layton_big_alice = Registration.find_by session_id: 'layton-bigalice'
josie_big_alice = Registration.find_by session_id: 'josie-bigalice'

# Race tries
RaceTry.find_or_create_by(
  registration_id: wilford_snowpiercer,
  user_id: wilford,
  duration: 500,
  start: '2021-04-19 00:00:00',
  moving_time: 260,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 1,
  race_try_id: 1
)

RaceTry.find_or_create_by(
  registration_id: melanie_snowpiercer,
  user_id: melanie,
  duration: 510,
  start: '2021-04-19 00:00:00',
  moving_time: 270,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 1,
  race_try_id: 2
)

RaceTry.find_or_create_by(
  registration_id: layton_snowpiercer,
  user_id: layton,
  duration: 520,
  start: '2021-04-19 00:00:00',
  moving_time: 280,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 1,
  race_try_id: 3
)

RaceTry.find_or_create_by(
  registration_id: josie_snowpiercer,
  user_id: josie,
  duration: 530,
  start: '2021-04-19 00:00:00',
  moving_time: 290,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 1,
  race_try_id: 4
)

RaceTry.find_or_create_by(
  registration_id: wilford_big_alice,
  user_id: wilford,
  duration: 500,
  start: '2021-04-19 00:00:00',
  moving_time: 260,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 2,
  race_try_id: 5
)

RaceTry.find_or_create_by(
  registration_id: melanie_big_alice,
  user_id: melanie,
  duration: 510,
  start: '2021-04-19 00:00:00',
  moving_time: 270,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 2,
  race_try_id: 6
)

RaceTry.find_or_create_by(
  registration_id: layton_big_alice,
  user_id: layton,
  duration: 520,
  start: '2021-04-19 00:00:00',
  moving_time: 280,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 2,
  race_try_id: 7
)

RaceTry.find_or_create_by(
  registration_id: josie_big_alice,
  user_id: josie,
  duration: 530,
  start: '2021-04-19 00:00:00',
  moving_time: 290,
  start_date_local: '2021-04-19 00:00:00',
  race_id: 2,
  race_try_id: 8
)