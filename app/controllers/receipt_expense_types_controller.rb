class ReceiptExpenseTypesController < ApplicationController
    def index
        receipt_expense_types = ReceiptExpenseType.all
        render :json => receipt_expense_types
    end

    def show
        receipt_expense_type = ReceiptExpenseType.find(params[:id])
        render :json => receipt_expense_type
    end

    def create
        receipt_expense_type = ReceiptExpenseType.new(set_param)
        if receipt_expense_type.save
            render :json => receipt_expense_type
        else 
            render json: {error: "try again..."}, status: 401
        end
    end

    def get_amount_per_type
        expense_and_amount = Hash.new
        user = current_user
        receipts_of_current_user = user.receipts
        receipts_of_current_user.map do |receipt|
            receipt.receipt_expense_types.map do |receipt_expense_type|
                if expense_and_amount.has_key?(receipt_expense_type.expense_type.category)
                    original_amount = expense_and_amount[receipt_expense_type.expense_type.category]
                    expense_and_amount[receipt_expense_type.expense_type.category] = original_amount + receipt_expense_type.amount
                else
                    expense_and_amount[receipt_expense_type.expense_type.category] = receipt_expense_type.amount
                end
            end
        end
        render json: expense_and_amount

    end
    private

    def set_param
        params.permit(:receipt_id, :expense_type_id, :amount)
    end
end