module Api
  module V1
    class PostsController < Api::V1::ApplicationController
      
      def index
        posts = Post.includes(:user).order(created_at: :desc)
        render json: posts, current_user: current_user
      end

      def show
        post = Post.find(params[:id])
        render json: post, current_user: current_user
      end
      

      def create
        return render json: { error: 'Unauthorized' }, status: :unauthorized unless authenticated?
      
        post = current_user.posts.build(post_params)
        if post.save
          render json: { post: post }, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end
      

      private

      def post_params
        params.require(:post).permit(:title, :description)
      end
    end
  end
end