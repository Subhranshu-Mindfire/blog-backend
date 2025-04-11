module Api
  module V1
    class SessionsController < Api::V1::ApplicationController
      def create
        user = User.find_by(email: user_params[:email])

        if user && user.authenticate(user_params[:password])
          token = generate_token(user)

          render json: {
            token: token,
            user: user
          }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def destroy
        token = extract_token_from_header

        if token.blank?
          render json: { error: 'No token provided' }, status: :bad_request
        elsif invalidate_token(token)
          render json: { message: 'Logged out successfully' }, status: :ok
        else
          render json: { error: 'Token not found or already logged out' }, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
