class RenameAllowedTokensToAllowedLists < ActiveRecord::Migration[7.2]
  def change
    rename_table :allowed_tokens, :allowed_lists
  end
end
