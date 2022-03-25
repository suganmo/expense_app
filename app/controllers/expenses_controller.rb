class ExpensesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_expense, only: [:expense_request,:confirm_expense, :approval_expense, :notice_expense]
  before_action :set_user, only: :show

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
      unless expense_params[:expense_confirmation].blank?
        @expenses.update(expense_params)
        flash[:success] = "経費申請をしました。"
      else
        flash[:success] = "申請先を選択してください。"
      end
      redirect_to users_path(id: current_user.id)
    end
  end
  
  def notice_expense
    @user = User.find(params[:id])
    @expense = Expense.find(params[:id])
    @expenses_sum = @expenses.all.sum(:expenses_money)
    @expenses_notices =  Expense.where(expense_confirmation: @user.name, expense_confirmation_status: "申請中").group_by(&:user_id)
  end
  
  def confirm_expense
    @user = User.find(params[:id])
    @expense = Expense.all
    @expenses_sum = @expenses.all.sum(:expenses_money)
    @expenses_request = @expenses.find_by(update_expense_day: @first_day)
    @expenses_request_count = Expense.where(expense_confirmation: @user.name, expense_confirmation_status: "申請中").count
  end
  
  def approval_expense
    ActiveRecord::Base.transaction do
      @expenses_request = @expenses.find_by(update_expense_day: @first_day)
      @expenses_request_count = Expense.where(expense_confirmation: @user.name, expense_confirmation_status: "申請中")
      @user = User.find(params[:id])
          if @expenses_request_count[:expense_confirmation_status] = "承認"
            @expenses_request_count.update(request_params)
          flash[:success] = "経費申請を承認しました"
        else
        flash[:danger] = "無効な入力データがあった為更新をキャンセルしました。"
        end
        redirect_to users_path(id: current_user.id)
      end
    end
  end
    
  def edit_overwork_request
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find(params[:id])
    @superiors = User.where(superior: true).where.not(id: @user.id)
  end
  private
  
  def expense_params
    params.require(:expense).permit(:expenses_day, :expenses_note, :expenses_money, :expense_confirmation , :update_expense_day , :expense_confirmation_status , :request_money).merge(user_id: current_user.id)
  end
  
  def request_params
    params.permit(Expense:[:expenses_day, :expenses_note, :expenses_money, :expense_confirmation , :update_expense_day , :expense_confirmation_status , :request_money]).merge(user_id: @user.id)
  end

  
