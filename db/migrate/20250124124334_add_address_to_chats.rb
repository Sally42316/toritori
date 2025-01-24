class AddAddressToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :address, :string
  end
end
