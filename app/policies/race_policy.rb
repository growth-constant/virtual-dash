class RacePolicy
  attr_reader :race, :user

  def initialize(user, race)
    @race = race
    @user = user
  end

  def create?
    @user.admin? || @user.race_admin?
  end

  def new?
    create?
  end

  def update?
    @user.admin? || (@user.race_admin? && @race.user_id == @user.id)
  end

  def edit?
    update?
  end

  class Scope
    attr_reader :race, :scope

    def initialize(race, scope)
      @race = race
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
