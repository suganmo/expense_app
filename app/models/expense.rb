class Expense < ApplicationRecord
  belongs_to :users, optional: true
end
