class Expense < Sequel::Model

  plugin :paranoid, enable_default_scope: true

  many_to_one :login, reciprocal: :expenses

  def self.for_month(date=Time.now)
    where { event_date >= date.beginning_of_month.to_date }.
    where { event_date <= date.end_of_month.to_date }
  end

  def self.for_login(name)
    where(login_id: Login.where(name: name.to_s))
  end

end
