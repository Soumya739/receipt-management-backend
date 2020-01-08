class ExpenseType < ApplicationRecord
    has_many :receipt_expense_types
    has_many :receipts, through: :receipt_expense_types
end
