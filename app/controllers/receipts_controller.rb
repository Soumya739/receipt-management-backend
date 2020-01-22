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
        # expense_array = params[:expense_type].split(',')
        receipt = Receipt.new(image: params[:image])
        receipt.user_id = user.id
        if receipt.save
            @receipt_url = receipt.image.service_url
           
            subscription_key = "Add your key here"
            endpoint = "Add endpoint here"
            if !subscription_key
                render json: {error: "Set your environment variables for your subscription key and endpoint."}, status: 500       
            end
            # uriBase = endpoint + "vision/v2.1/ocr"
            # header = {'Content-Type': 'application/json', 'Ocp-Apim-Subscription-Key': subscription_key}
            # uri = URI.parse(uriBase)
            # data= {url: @receipt_url}
            # http = Net::HTTP.new(uri.host, uri.port)
            # request = Net::HTTP::Post.new(uri.request_uri, header)
            # http.use_ssl = true
            # request.body = data.to_json
            # byebug
            # response = http.request(request)
            
            uriBase = endpoint + "vision/v2.1/read/core/asyncBatchAnalyze"
            header = {'Content-Type': 'application/json', 'Ocp-Apim-Subscription-Key': subscription_key}
            uri = URI.parse(uriBase)
            data= {url: @receipt_url}
            http = Net::HTTP.new(uri.host, uri.port)
            request = Net::HTTP::Post.new(uri.request_uri, header)
            http.use_ssl = true
            request.body = data.to_json
            response = http.request(request)
            sleep 10
            operationLocation = response["Operation-Location"]
            uri = URI.parse(operationLocation)
            header = {'Content-Type': 'application/json', 'Ocp-Apim-Subscription-Key': subscription_key}
            http = Net::HTTP.new(uri.host, uri.port)
            req = Net::HTTP::Get.new(uri.request_uri, header)
            http.use_ssl = true
            rep = http.request(req)
            render json: {imageData: [rep.body], receiptId: receipt.id}
        else 
            render json: {error: "try again..."}, status: 401
        end
    end

    def update
        user = current_user
        expense_array_lowercase = params[:expense_type].map do |category| 
            category.downcase
        end
        number_of_expense_types = params[:expense_type].length
        amt_per_expense_type = (params[:total_amount].to_f/number_of_expense_types).ceil
        expense_type_ids = expense_array_lowercase.map do |category|
            expense_category = ExpenseType.find_by(category: category)
            if !expense_category
                expense_category = ExpenseType.create(category: category)
            end
            expense_category.id
        end
        receipt = Receipt.find(params[:receipt_id])
        receipt.expense_type = expense_array_lowercase
        receipt.store = params[:store]
        receipt.total_amount = params[:total_amount]
        receipt.generated_on = params[:generated_on]
        if receipt.save
            expense_type_ids.each do |expense_type_id|
                ReceiptExpenseType.create(receipt_id: receipt.id, expense_type_id: expense_type_id, amount: amt_per_expense_type)
            end
            render :json => receipt
        else 
            render json: {error: "try again..."}, status: 401
        end

    end

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
