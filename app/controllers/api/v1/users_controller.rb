module Api
  module V1
    class UsersController < ApplicationController
      
      def show
      end
      
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: @user.errors.messages, status: 400
        end
      end
      
      def update
      end
      
      private
      
        def user_params
          params.require(:user).permit(:name, :email)
        end
    end
  end
end