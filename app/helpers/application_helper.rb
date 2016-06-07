module ApplicationHelper

  def title
    @title ||= "#{ENV['ROOMMATE_TITLE'] || 'Roommate'} Expense Tracker"
  end

end
