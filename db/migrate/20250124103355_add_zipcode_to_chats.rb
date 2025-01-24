class AddZipcodeToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :zipcode, :string
  end
end
