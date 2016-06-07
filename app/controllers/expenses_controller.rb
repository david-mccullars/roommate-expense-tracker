class ExpensesController < ApplicationController

  before_action :authenticate

  def index
    @month = Date.strptime(params[:month], '%Y%m') rescue Time.now
    @expenses = {}
    Login.ordered.each do |login|
      @expenses[login.name] = Expense.for_month(@month).where(login_id: login.id).order(:event_date, :id)
    end
  end

  def create
    @expense = Expense.new(params[:expense].merge(login_id: @login.id))
    @expense.save
    redirect_to '/'
  end

  def destroy
    Expense[params[:id]].destroy
    redirect_to '/'
  end

  private

  def authenticate
    @login = Login.where(id: session[:login]).first or redirect_to '/login'
  end

end
