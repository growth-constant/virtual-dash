# Users
wilford = User.find_by email: 'mr.wilford@wilford.co'
melanie = User.find_by email: 'melaniec@wilford.co'
layton = User.find_by email: 'andre@thetail.xyz'
josie = User.find_by email: 'josie@thetail.xyz'

# Races
snowpiercer_race = Race.find_by title: 'Snowpiercer'
big_alice_race = Race.find_by title: 'Big Alice Race'

puts "Data thingy"

puts snowpiercer_race[:id]
puts layton[:id]

# Registrations
Registration.create!([
  {
    race_id: snowpiercer_race[:id],
    user_id: wilford[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'wilford-snowpiercer'  
  },
  {
    race_id: snowpiercer_race[:id],
    user_id: melanie[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'melanie-snowpiercer'
  },
  {
    race_id: snowpiercer_race[:id],
    user_id: layton[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'layton-snowpiercer'
  },
  {
    race_id: snowpiercer_race[:id],
    user_id: josie[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'josie-snowpiercer'
  },
  {
    race_id: big_alice_race[:id],
    user_id: wilford[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'wilford-bigalice'
  },
  {
    race_id: big_alice_race[:id],
    user_id: melanie[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'melanie-bigalice'
  },
  {
    race_id: big_alice_race[:id],
    user_id: layton[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'layton-bigalice'
  },
  {
    race_id: big_alice_race[:id],
    user_id: josie[:id],
    status: 'registered',
    payment_status: 'paid',
    agreements_signed: true,
    session_id: 'josie-bigalice'
  },
])