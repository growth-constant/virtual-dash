class Prize < ApplicationRecord
  belongs_to :race
  belongs_to :user

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
