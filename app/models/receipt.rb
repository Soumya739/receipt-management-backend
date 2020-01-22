class Receipt < ApplicationRecord
    belongs_to :user
    has_many :receipt_expense_types
    has_many :expense_types, through: :receipt_expense_types
    has_one_attached :image

end
