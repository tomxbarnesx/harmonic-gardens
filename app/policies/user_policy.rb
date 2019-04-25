class UserPolicy < ApplicationPolicy

    def show?
        user.role == 'Admin' || user.role == 'Foreman' || record.id == user.id
    end

    def update?
        user.role == 'Admin' || (user.role == 'Foreman' && record.role == 'Worker') || record.id == user.id
    end

    def login?
        record.id == user.id
    end

    def destroy?
        (user.role == 'Admin' && record.role != 'Admin') || (user.role == 'Foreman' && record.role == 'Worker') 
    end

    def admin_edit?
        (user.role == 'Admin' && record.id == user.id) || (user.role == 'Admin' && (record.role == 'Foreman' || record.role == 'Worker')) || (user.role == 'Foreman' && record.role == 'Worker') || (user.role == 'Designer' && record.id == user.id)
    end

end
