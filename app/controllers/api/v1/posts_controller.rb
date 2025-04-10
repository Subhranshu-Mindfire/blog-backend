module Api
  module V1
    class PostsController < Api::V1::ApplicationController
      def index
        render json:{
          posts: Post.all
        }
      end
    end
  end
end