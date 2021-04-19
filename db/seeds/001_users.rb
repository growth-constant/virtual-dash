# Note: This users cannot be acceses via log in, they only are used to fill two example races.

User.find_or_create_by(
  name: 'Joseph Wilford'
  last_name: 'Wilford'
  first_name: 'Joseph'
  email: 'mr.wilford@wilford.co',
  encrypted_password: rand(36**16).to_s(36),
  image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
)

User.find_or_create_by(
  name: 'Melanie Cavill'
  last_name: 'Cavill'
  first_name: 'Melanie'
  email: 'melaniec@wilford.co',
  encrypted_password: rand(36**16).to_s(36),
  image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
)

User.find_or_create_by(
  name: 'Andre Layton'
  last_name: 'Layton'
  first_name: 'Andre'
  email: 'andre@thetail.xyz',
  encrypted_password: rand(36**16).to_s(36),
  image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
)

User.find_or_create_by(
  name: 'Josie Wellstead'
  last_name: 'Wellstead'
  first_name: 'Josie'
  email: 'josie@thetail.xyz',
  encrypted_password: rand(36**16).to_s(36),
  image: 'https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-800a7033cc92b2a5548399e26b1ef42414dd1a9cb13b99454222d38d58fd28ef.png'
)