class ExpensesController < ApplicationController

  before_action :require_authorization

  def index
    month = Date.strptime(params[:month], '%Y%m') rescue Time.current
    expenses = Expense.includes(:login).for_month(month).order(:event_date, :id).group_by { |e| e.login.name }
    render json: { month: month, expenses: expenses }, except: [:login_id, :created_at, :deleted_at]
  end

  def create
    expense = Expense.new(params.permit(:amount, :description, :event_date, :shared).merge(login_id: login.id))
    expense.save!
    render json: expense, except: [:login_id, :created_at, :deleted_at]
  end

  def destroy
    destroyed = Expense.where(login_id: login.id, id: params.fetch(:id).to_i).destroy_all
    render json: destroyed.first
  end

end
