class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.integer :ostatus, null: false, default:0

      t.timestamps
    end
  end
end
