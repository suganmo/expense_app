class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: :show
  before_action :set_user, only: :show
  def show
    @user = User.find(params[:id]) #追記
    @superiors = User.where(superior: true).where.not(id: @user.id)
    @expenses_sum = @expenses.all.sum(:expenses_money)
  end
end
