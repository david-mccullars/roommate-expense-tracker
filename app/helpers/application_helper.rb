module ApplicationHelper

  def title
    @title ||= "#{ENV['ROOMMATE_TITLE'] || 'Roommate'} Expense Tracker"
  end

  def amount_paid
    @amount_paid ||= @expenses.dup.update(@expenses) do |name, expenses|
      expenses.map(&:amount).reduce(:+) || BigDecimal.new(0.0, 2)
    end
  end

  def amount_due
    @amount_due ||= @expenses.dup.update(@expenses) do |name, expenses|
      amount_due = expenses.map do |expense|
        expense.shared? ? expense.amount / 2.0 : expense.amount
      end.reduce(:+)
      amount_due ? amount_due.round(2) : BigDecimal.new(0.0, 2)
    end
  end

  def summary
    (debtor, v1), (debtee, v2) = amount_due.sort_by(&:last) # NOTE: We currently only support 2 logins
    if debtor && v1 && debtee && v2 && v1 != v2
      [debtor, debtee, v2 - v1]
    end
  end

end
