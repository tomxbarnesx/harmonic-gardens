class ShiftPolicy < ApplicationPolicy

    def index?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker' || user.role == 'Designer'
    end

    def show?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker' || user.role == 'Designer'
    end
    
    def create?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Worker' || user.role == 'Designer'
    end

    def destroy?
        user.role == 'Admin' || user.role == 'Foreman' || user.role == 'Designer' || record.user_id == user
    end
end
