
module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticated?

      def create
        like = post.likes.find_or_initialize_by(user: current_user)
        if like.persisted?
          render json: { message: "Already liked" }, status: :ok
        else
          like.save!
          @post.increment!(:no_of_likes)
          render json: { message: "Liked" }, status: :created
        end
      end

      def destroy
        like = post.likes.find_by(user: current_user)
        if like
          like.destroy
          @post.decrement!(:no_of_likes)
          render json: { message: "Unliked" }, status: :ok
        else
          render json: { error: "Not liked yet" }, status: :not_found
        end
      end

      private

      def post
        @post ||= Post.find(params[:post_id])
      end
    end
  end
end
