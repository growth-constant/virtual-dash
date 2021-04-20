# Note: This users cannot be acceses via log in, they only are used to fill two example races.

User.create!([
  {
    name: 'Joseph Wilford',
    last_name: 'Wilford',
    first_name: 'Joseph',
    email: 'mr.wilford@wilford.co',
    password: rand(36**16).to_s(36),
    encrypted_password: rand(36**16).to_s(36),
    image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
  },
  {
    name: 'Melanie Cavill',
    last_name: 'Cavill',
    first_name: 'Melanie',
    email: 'melaniec@wilford.co',
    password: rand(36**16).to_s(36),
    encrypted_password: rand(36**16).to_s(36),
    image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
  },
  {
    name: 'Andre Layton',
    last_name: 'Layton',
    first_name: 'Andre',
    email: 'andre@thetail.xyz',
    password: rand(36**16).to_s(36),
    encrypted_password: rand(36**16).to_s(36),
    image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
  },
  {
    name: 'Josie Wellstead',
    last_name: 'Wellstead',
    first_name: 'Josie',
    email: 'josie@thetail.xyz',
    password: rand(36**16).to_s(36),
    encrypted_password: rand(36**16).to_s(36),
    image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
  },
])