module Api
  module V1
    class PostsController < Api::V1::ApplicationController
      
      def index
        posts = Post.includes(:user, :likes).order(created_at: :desc)
        render json: posts.map { |post|
        post.as_json(
          only: [:id, :title, :description, :created_at, :no_of_likes],
        ).merge(
          truncated_description: post.truncate_post,
          user: {
            id: post.user.id,
            name: post.user.name
          },
          liked_by_user: current_user.present? && post.likes.exists?(user_id: current_user.id)
        )
      }
      end

      def show
        post = Post.find(params[:id])
        render json:post.as_json(
          only: [:id, :title, :description, :created_at, :no_of_likes],
        ).merge(liked_by_user: current_user.present? && post.likes.exists?(user_id: current_user.id)), include: :user
      end

      def create
        if authenticated?
          post = current_user.posts.build(post_params)
          if post.save
            render json: { post: post }, status: :created
          else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :description)
      end
    end
  end
end