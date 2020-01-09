class ApplicationController < ActionController::API
    def issue_token(user)
        # encode is inbuilt method in jwt - 1st argument= payload, 2nd - seed string, algorithem
        # for more info look jwt website
        JWT.encode({user_id: user.id}, 'soumya_secret_key', 'HS256')
    end

    def token
        request.headers['Authorization']
    end

    def decoded_token
        begin
            JWT.decode(token, 'soumya_secret_key', true, { :algorithm => 'HS256' })
        rescue JWT::DecodeError
            [{error: "Invalid Token"}]
        end
    end

    def user_id
        decoded_token.first['user_id']
    end 

    def current_user
        @user ||= User.find_by(id: user_id)
    end

    def logged_in?
    !!current_user
    end


end
