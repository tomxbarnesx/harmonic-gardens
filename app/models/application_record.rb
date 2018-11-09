class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_name
    "#{first_name} #{last_name}"
  end

  def abbrv_name
      "#{first_name.slice(0,1)}. #{last_name}"
  end

  def initials
    "#{first_name.slice(0,1)}#{last_name.slice(0,1)}"
  end
end
