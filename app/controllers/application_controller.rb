class ApplicationController < ActionController::API

  include Authorization

  def index
    @title = "#{ENV['ROOMMATE_TITLE'] || 'Roommate'} Expense Tracker"
    render html: ERB.new(Rails.root.join('app/views/index.html.erb').read).result(send :binding).html_safe
  end

  def bundle_js
    render js: Net::HTTP.get(URI 'http://localhost:3001/bundle.js')
  end

end
