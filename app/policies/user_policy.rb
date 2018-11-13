class UserPolicy < ApplicationPolicy

    def show?
        user.role == 'admin' || user.role == 'foreman' || record.user == user
    end

    def update?
        user.role == 'admin' || (user.role == 'foreman' && record.role == 'worker') || record.id == user.id
    end

    def destroy?
        (user.role == 'admin' && record.role != 'admin') || (user.role == 'foreman' && record.role == 'worker') 
    end

end
