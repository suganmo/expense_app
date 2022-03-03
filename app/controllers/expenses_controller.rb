class ExpensesController < ApplicationController
  def new
  end
  
  def expense_create
    @expense = Expense.all
    @expenses = Expense.new(expense_params)
    if @expenses.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to users_path(id: current_user.id)
    else
      render '/users'
    end
  end
  
  def expense_destroy
    @expense = Expense.all
    @expenses = Expense.find(params[:id])
    @expenses.destroy
    flash[:success] = "#{@expenses.expenses_note}のデータを削除しました。"
    redirect_to users_path(id: current_user.id)
  end
  
  def expense_request
    ActiveRecord::Base.transaction do
      @user = User.find(params[:id])
      @expenses = Expense.find(params[:id])
      @superiors = User.where(superior: true).where.not(id: @user.id)
      unless monthly_params[:expense_confirmation].blank?
        @attendance.update_attributes(monthly_params)
        flash[:success] = "月次申請をしました。"
      else
        flash[:success] = "申請先を選択してください。"
      end
      redirect_to user_url(@user)
    end
  end
  private
  
  def expense_params
    params.permit( :worked_on, :expenses_day, :expenses_note, :expenses_money)
  end
  
end
