class Prize < ApplicationRecord
  belongs_to :race
  belongs_to :user

  # Get the prizes for a given race
  def self.race_prizes(race)
    leaderboard = Leaderboard.new(race).call
    if leaderboard[:competitors]
      leaderboard[:competitors].each_with_index do | try, index |
        p '>>> PRIZE <<<'
        p "Index => #{index}"
        p "User ID => #{try[:id]}"
        p "Race ID => #{try[:race_id]}"

        unless leaderboard[:prizes].nil?
          case index
          when 0
            prize = leaderboard[:prizes][:first]
          when 1
            prize = leaderboard[:prizes][:second]
          when 2
            prize = leaderboard[:prizes][:third]
          else
            prize = 0
          end
        end

        p "Amount => #{prize}"

      end
    end
  end

end
