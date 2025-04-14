module Api
  module V1
    class PostsController < Api::V1::ApplicationController
      
      def index
        if params[:user_id]
          posts =  Post.where(user_id: params[:user_id]).includes(:user, comments: :user).order(created_at: :desc)
        else
          posts = Post.includes(:user, comments: :user).order(created_at: :desc)
        end
        if authenticated?
          render json: posts, current_user: current_user
        else
          render json: posts
        end
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