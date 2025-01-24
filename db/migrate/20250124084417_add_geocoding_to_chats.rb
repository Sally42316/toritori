class AddGeocodingToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :address, :string, null: false, default: ""
    add_column :chats, :latitude, :float, null: false, default: 0
    add_column :chats, :longitude, :float, null: false, default: 0
  end
end
