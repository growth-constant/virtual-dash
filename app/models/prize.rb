class Prize < ApplicationRecord
  belongs_to :race
  belongs_to :user

  scope :prizes_from_race, lambda { | race |
    includes(:user)
    .where('race_id': race.id)
    .references(:user)
  } 

  scope :prizes_from_user, lambda { | user |
    includes(:race)
    .where('user_id': user.id)
    .references(:race)
  }

  scope :prize_from_user_race, lambda { | user, race |
    includes(:race, :user)
    .where('user_id': user.id, 'race_id': race.id)
    .references(:race, :user)
  }

  def self.create_race_prizes(race)
    leaderboard = Leaderboard.new(race).call
    leaderboard[:competitors].each_with_index do | try, index |

      dupl_item = Prize.find_by(user_id: try[:id], race_id: try[:race_id])

      if dupl_item.nil?
        amount = Leaderboard.get_prize_amount(leaderboard, try[:id])
        prize_item = Prize.new(
          user_id: try[:id],
          race_id: try[:race_id],
          amount: amount
        ).save
      end

    end
  end

end
