class ReceiptReceiptExpenseTypesController < ApplicationController
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
    private

    def set_param
        params.permit(:receipt_id, :expense_type_id)
    end
end