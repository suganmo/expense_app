require 'test_helper'

class ExpenseControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get expense_new_url
    assert_response :success
  end

end
