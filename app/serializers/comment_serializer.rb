class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :username, :user_id,

  def username
    object.user.name
  end
  def user_id
    object.user.id
  end
end
