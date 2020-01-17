class AuthController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = issue_token(user)
          render json: {user: user, jwt: token}
        else
          render json: {error: 'User or password could not be matched'}, status: 401
        end
      end
    
      def show
        user = User.find_by(id: user_id)
        if logged_in?
          render json: { user: user }
        else
          render json: {error: 'No user could be found'}, status: 401
        end
      end

end