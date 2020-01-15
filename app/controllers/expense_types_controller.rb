class ExpenseTypesController < ApplicationController

    def index
        expense_types = ExpenseType.all
        render :json => expense_types
    end

    def show
        expense_type = ExpenseType.find(params[:id])
        render :json => expense_type
    end

    def create
        expense_type = ExpenseType.new(set_param)
        if expense_type.save
            render :json => expense_type
        else 
            render json: {error: "try again..."}, status: 401
        end
    end
    private

    def set_param
        params.permit(:category)
    end

end
