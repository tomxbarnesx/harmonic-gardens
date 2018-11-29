class UserPolicy < ApplicationPolicy

    def show?
        user.role == 'Admin' || user.role == 'Foreman' || record.user == user
    end

    def update?
        user.role == 'Admin' || (user.role == 'Foreman' && record.role == 'Worker') || record.id == user.id
    end

    def destroy?
        (user.role == 'Admin' && record.role != 'Admin') || (user.role == 'Foreman' && record.role == 'Worker') 
    end

end
