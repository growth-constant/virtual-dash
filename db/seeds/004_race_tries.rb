# Users
wilford = User.find(1)
melanie = User.find(2)
layton = User.find(3)
josie = User.find(4)

# Registrations
wilford_snowpiercer = Registration.find(1)
melanie_snowpiercer = Registration.find(2)
layton_snowpiercer = Registration.find(3)
josie_snowpiercer = Registration.find(4)
wilford_big_alice = Registration.find(5)
melanie_big_alice = Registration.find(6)
layton_big_alice = Registration.find(7)
josie_big_alice = Registration.find(8)

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