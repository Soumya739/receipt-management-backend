class ReceiptExpenseType < ApplicationRecord
    belongs_to :expense_type
    belongs_to :receipt
end
