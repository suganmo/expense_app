class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.date "expenses_day"
      t.string "expenses_note"
      t.decimal "expenses_money"
      t.string "expense_confirmation"  
      t.date "update_expense_day"
      t.string "expense_confirmation_status"
      t.decimal "request_money"
      t.timestamps
    end
  end
end
