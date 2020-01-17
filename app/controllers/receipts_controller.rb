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
        user = current_user
        user_receipts = user.receipts
        render :json => user_receipts
    end

    def create
        user = current_user
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
        receipt.user_id = user.id
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

    # def get_filtered_receipts_data
    #     user = current_user
    #     receipts = user.receipts
    #     if params[:filterType] == "store"
    #         receipts_filtered_by_store = receipts.where(store: params[:subFilterType])
    #         render :json => receipts_filtered_by_store
    #     end
    #     # render :json => user_receipts
    # end

    def get_all_user_stores
        user = current_user
        receipts = user.receipts
        stores = []
        receipts.map do |receipt|
            stores.push(receipt.store)
        end
        render :json => stores.uniq
    end

    private

    def set_param
        params.permit(:image, :store, :total_amount, :generated_on)
    end

end
