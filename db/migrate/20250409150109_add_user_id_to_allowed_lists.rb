class AddUserIdToAllowedLists < ActiveRecord::Migration[7.2]
  def change
    add_reference :allowed_lists, :user, null: false, foreign_key: true
  end
end
