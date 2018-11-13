class ShiftPolicy < ApplicationPolicy

    def index?
        user.role == 'admin' || user.role == 'foreman' || user.role == 'worker'
    end

    def show?
        user.role == 'admin' || user.role == 'foreman' || user.role == 'worker'
    end
    
    def create?
        user.role == 'admin' || user.role == 'foreman' || user.role == 'worker'
    end

    def destroy?
        user.role == 'admin' || user.role == 'foreman' || record.user == user
    end
end
