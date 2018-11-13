class ShiftPolicy < ApplicationPolicy
    def update?
        user.role == 'admin' || user.role == 'foreman'
    end
    
    def destroy?
        user.role == 'admin' || user.role == 'foreman' || record.user == user
    end
end
