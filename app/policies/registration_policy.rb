class RegistrationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    r = Registration.find_by(user: @user, race: @record.race)
    if r.present? 
      if r.status.require_agreements?
        return true
      end
    else
      return true
    end
    return false
  end

  def status? 
    @record.user_id == @user.id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end