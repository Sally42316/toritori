class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :name
      t.text :detail
      t.integer :owner_id

      t.timestamps
    end
  end
end
