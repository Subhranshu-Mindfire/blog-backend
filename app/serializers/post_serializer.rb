
class PostSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :description, :truncated_description, :created_at, :no_of_likes, :liked_by_user

  belongs_to :user

  def truncated_description
    object.truncate_post
  end

  def liked_by_user
    current_user = instance_options[:current_user]
    return false unless current_user

    object.likes.exists?(user_id: current_user.id)
  end
end

