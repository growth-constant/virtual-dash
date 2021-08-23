# frozen_string_literal: true

# class RaceTry
class RaceTry < ApplicationRecord
  belongs_to :registration
  belongs_to :user

  # Scopes
  scope :user_segments, lambda { |user, segment_id|
    where(user_id: user.id, segment_id: segment_id).order('start DESC')
  }

  scope :last_try, lambda { |user, segment_id|
    where(user_id: user.id, segment_id: segment_id).order('start DESC').limit(1)
  }

  scope :tries_per_user, lambda { | race |
    select('user_id, COUNT(*) as tries')
      .where('race_id': race.id)
      .group(:user_id)
  }

  scope :leaders, lambda { |race, limit|
    find_by_sql("
      SELECT *
      FROM ( 
        SELECT DISTINCT ON (name) name, user_id AS id, race_id, MIN(duration) AS duration, image_medium AS image, start
          FROM race_tries 
          INNER JOIN users ON users.id = race_tries.user_id
          WHERE race_tries.race_id = #{race.id}
          GROUP BY race_tries.user_id, name, image_medium, race_tries.duration, race_tries.start, race_tries.race_id
          ORDER BY name
      ) AS races
      ORDER BY duration
      LIMIT #{limit};
    ")
  }

  scope :leaders_men, lambda {
    select('name as name, image_medium as image, MIN(duration) as duration, gender')
      .joins(:user)
      .where('users.gender': 'male')
      .group(:user_id, :name, :image_medium, :gender)
      .order(3)
  }

  scope :leaders_women, lambda {
    select('name as name, image_medium as image, MIN(duration) as duration, gender')
      .joins(:user)
      .where('users.gender': 'female')
      .group(:user_id, :name, :image_medium, :gender)
      .order(3)
  }

end
