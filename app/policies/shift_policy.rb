class ShiftPolicy < ApplicationPolicy

    def index?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker'
    end

    def show?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker'
    end
    
    def create?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker'
    end

    def destroy?
        user.role == 'Admin' || user.role == 'Foreman' || record.user == user
    end
end
