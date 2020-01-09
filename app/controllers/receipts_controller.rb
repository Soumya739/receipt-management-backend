class ReceiptsController < ApplicationController

    def index
        receipts = Receipt.all
        render :json => receipts
    end

    def show
        receipt = Receipt.find(params[:id])
        render :json => receipt
    end

    def create
        receipt = Receipt.new(set_param)
        if receipt.save
            render :json => receipt
        end
    end

    private

    def set_param
        params.require(:receipt).permit(:image_url, :store, :total_amount, :generated_on, :user_id )
    end
end
