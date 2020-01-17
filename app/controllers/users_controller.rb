class UsersController < ApplicationController
    def index
        users = User.all
        render :json => users
    end

    def show
        user = User.find(params[:id])
        render :json => user
    end

    def show_current_user
        user = current_user
        render :json => user
    end

    def create
        user = User.new(set_param)
        if user.save
            render :json => user
        else 
            render json: {error: "try again..."}, status: 401
        end
    end

    def update
        user1 = current_user
        user2 = User.find(params[:id])
        if user1 == user2
            user1.update(set_param)
            render :json => user1
        else 
            render json: {error: "try again..."}, status: 401
        end
    end

    private

    def set_param
        params.require(:user).permit(:username, :email, :gender, :city, :state, :country, :contact_num, :password, :password_confirmation)
    end
end
