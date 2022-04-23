class UsersController < ApplicationController
  protect_from_forgery with: :exception  
  before_action :set_expense, only: :show
  before_action :set_user, only: :show
  #before_action :expense_id, only: :show

  def show
    @expense = Expense.all
    @expenses_sum = @expense.all.sum(:expenses_money)
    @expenses_request = @expenses.find_by(update_expense_day: @first_day)
    @expenses_request_count = Expense.where(expense_confirmation: @user.name, expense_confirmation_status: "申請中").count
  end
 
end
