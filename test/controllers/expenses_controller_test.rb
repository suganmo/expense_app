require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get notice_expense" do
    get expenses_notice_expense_url
    assert_response :success
  end

end
