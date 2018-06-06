class Expense < ApplicationRecord

  acts_as_paranoid

  belongs_to :login, inverse_of: :expenses

  def self.for_month(date = Time.current)
    where(event_date: date.beginning_of_month.to_date .. date.end_of_month.to_date)
  end

  def self.for_login(name)
    where(login_id: Login.where(name: name.to_s))
  end

end
