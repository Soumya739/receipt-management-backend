class ReceiptsController < ApplicationController

    def index
        receipts = Receipt.all
        render :json => receipts
    end

    def show
        receipt = Receipt.find(params[:id])
        render :json => receipt
    end


    def show_user_receipts
        receipts = Receipt.where(user_id: user_id)
        render :json => receipts
    end

    def create
        expense_array = params[:expense_type].split(',')
        expense_array_lowercase = expense_array.map do |category| 
            category.downcase
        end 
        
        expense_type_ids = expense_array_lowercase.map do |category|
            expense_category = ExpenseType.find_by(category: category)
            if !expense_category
                expense_category = ExpenseType.create(category: category)
            end
            expense_category.id
        end
        receipt = Receipt.new(set_param)
        receipt.expense_type = expense_array_lowercase
        if receipt.save
            expense_type_ids.each do |expense_type_id|
                ReceiptExpenseType.create(receipt_id: receipt.id, expense_type_id: expense_type_id)
            end
            render :json => receipt
        else 
            render json: {error: "try again..."}, status: 401
        end
    end
    private

    def set_param
        params.permit(:image, :store, :total_amount, :generated_on, :user_id)
    end
end
