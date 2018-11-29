class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.role == 'Admin' || user.role == 'Foreman'
  end

  def show?
    user.role == 'Admin' || user.role == 'Foreman'
  end

  def create?
    user.role == 'Admin' || user.role == 'Foreman'
  end

  def new?
    create?
  end

  def update?
    user.role == 'Admin' || user.role == 'Foreman'
  end

  def edit?
    update?
  end

  def destroy?
    user.role == 'Admin' || user.role == 'Foreman'
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
