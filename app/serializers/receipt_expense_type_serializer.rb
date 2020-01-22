class ReceiptExpenseTypeSerializer < ActiveModel::Serializer
  attributes :id, :receipt_id, :expense_type_id, :amount
end
