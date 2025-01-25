class AddParentChatIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :parent_chat_id, :integer
  end
end
