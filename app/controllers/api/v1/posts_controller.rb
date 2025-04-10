module Api
  module V1
    class PostsController < Api::V1::ApplicationController
      def index
        render json:{
          posts: Post.all
        }, include: :user
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