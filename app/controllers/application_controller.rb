class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    users_show_path(id: current_user.id)
  end
    
  #def expense_id
  #  @expense_id = Expense.find(params[:id])
  #end

  def expense
  @expense = Expense.find(params[:id])
  end
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def set_expense
    @user = User.find(params[:id])
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @expenses = Expense.where(expenses_day: @first_day..@last_day).order(:expenses_day)
  end 
  
  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
    devise_parameter_sanitizer.permit(:show, keys: [:user_id])
    devise_parameter_sanitizer.permit(:notice_expense, keys: [:user_id])

  end
end
