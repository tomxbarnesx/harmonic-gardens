class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.role == 'admin' || user.role == 'foreman'
  end

  def show?
    user.role == 'admin' || user.role == 'foreman'
  end

  def create?
    user.role == 'admin' || user.role == 'foreman'
  end

  def new?
    create?
  end

  def update?
    user.role == 'admin' || user.role == 'foreman'
  end

  def edit?
    update?
  end

  def destroy?
    user.role == 'admin' || user.role == 'foreman'
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
