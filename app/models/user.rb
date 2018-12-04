class User < ApplicationRecord
  has_many :shifts, dependent: :nullify
  has_many :invoices
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :username, message: "Username already taken."
 
  validates_presence_of :first_name, message: "Enter a first name."
  validates_presence_of :last_name, message: "Enter a last name."
  validates_presence_of :username, message: "Enter a username."

  enum role: [:Worker, :Foreman, :Admin]

  after_initialize do
    if self.new_record?
      self.role ||= :Worker
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def earnings_calculator(period)
    total = 0
    if period == "week"
      date_beginning_this_week = Date.today.beginning_of_week
      shifts = Shift.where(start_time: date_beginning_this_week..(DateTime.now)).where(user_id: self.id)
      shifts.each do |s|
          total += s.earned
      end
    elsif period == "month"
      date_beginning_this_month = Date.today.beginning_of_month
      shifts = Shift.where(start_time: date_beginning_this_month..(DateTime.now)).where(user_id: self.id)
      shifts.each do |s|
        total += s.earned
      end
    end
    return total
  end

  # def week_hours
    
  # end

end
