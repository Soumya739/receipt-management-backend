class ReceiptExpenseTypeSerializer < ActiveModel::Serializer
  attributes :id, :receipt, :expense_type
end
