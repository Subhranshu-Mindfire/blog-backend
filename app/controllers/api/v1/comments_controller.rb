
module Api
  module V1
    class CommentsController < Api::V1::ApplicationController
      before_action :authenticated?
      
      def create
        @post = Post.find(params[:post_id])
        comment = @post.comments.new(comment_params)
        comment.user = current_user

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
      def comment_params
        params.require(:comment).permit(:description)
      end
    end
  end 
end