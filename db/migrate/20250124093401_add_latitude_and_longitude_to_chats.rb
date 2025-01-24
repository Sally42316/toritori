class AddLatitudeAndLongitudeToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :latitude, :float
    add_column :chats, :longitude, :float
  end
end
