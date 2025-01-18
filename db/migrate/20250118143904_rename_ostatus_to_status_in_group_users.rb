class RenameOstatusToStatusInGroupUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_users, :ostatus, :status
  end
end
