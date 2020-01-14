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
        receipt = Receipt.new(set_param)
        receipt.expense_type = expense_array
        if receipt.save
            render :json => receipt
        end
    end
    private

    def set_param
        params.permit(:image, :store, :total_amount, :generated_on, :user_id)
    end
end
