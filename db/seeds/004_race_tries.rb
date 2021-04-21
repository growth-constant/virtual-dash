# Users
wilford = User.find_by email: 'mr.wilford@wilford.co'
melanie = User.find_by email: 'melaniec@wilford.co'
layton = User.find_by email: 'andre@thetail.xyz'
josie = User.find_by email: 'josie@thetail.xyz'

# Races
snowpiercer_race = Race.find_by title: 'Snowpiercer'
big_alice_race = Race.find_by title: 'Big Alice Race'

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
RaceTry.create!([
  {
    registration_id: wilford_snowpiercer[:id],
    user_id: wilford[:id],
    duration: 500,
    start: '2021-04-19 00:00:00',
    moving_time: 260,
    start_date_local: '2021-04-19 00:00:00',
    race_id: snowpiercer_race[:id],
    race_try_id: 1
  },
  {
    registration_id: melanie_snowpiercer[:id],
    user_id: melanie[:id],
    duration: 510,
    start: '2021-04-19 00:00:00',
    moving_time: 270,
    start_date_local: '2021-04-19 00:00:00',
    race_id: snowpiercer_race[:id],
    race_try_id: 2
  },
  {
    registration_id: layton_snowpiercer[:id],
    user_id: layton[:id],
    duration: 520,
    start: '2021-04-19 00:00:00',
    moving_time: 280,
    start_date_local: '2021-04-19 00:00:00',
    race_id: snowpiercer_race[:id],
    race_try_id: 3
  },
  {
    registration_id: josie_snowpiercer[:id],
    user_id: josie[:id],
    duration: 530,
    start: '2021-04-19 00:00:00',
    moving_time: 290,
    start_date_local: '2021-04-19 00:00:00',
    race_id: snowpiercer_race[:id],
    race_try_id: 4
  },
  {
    registration_id: wilford_big_alice[:id],
    user_id: wilford[:id],
    duration: 500,
    start: '2021-04-19 00:00:00',
    moving_time: 260,
    start_date_local: '2021-04-19 00:00:00',
    race_id: big_alice_race[:id],
    race_try_id: 5
  },
  {
    registration_id: melanie_big_alice[:id],
    user_id: melanie[:id],
    duration: 510,
    start: '2021-04-19 00:00:00',
    moving_time: 270,
    start_date_local: '2021-04-19 00:00:00',
    race_id: big_alice_race[:id],
    race_try_id: 6
  },
  {
    registration_id: layton_big_alice[:id],
    user_id: layton[:id],
    duration: 520,
    start: '2021-04-19 00:00:00',
    moving_time: 280,
    start_date_local: '2021-04-19 00:00:00',
    race_id: big_alice_race[:id],
    race_try_id: 7
  },
  {
    registration_id: josie_big_alice[:id],
    user_id: josie[:id],
    duration: 530,
    start: '2021-04-19 00:00:00',
    moving_time: 290,
    start_date_local: '2021-04-19 00:00:00',
    race_id: big_alice_race[:id],
    race_try_id: 8
  },
])