module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def create
        @user = User.new(user_params)
        if @user.save
          render json: { message: 'User created successfully'}
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end