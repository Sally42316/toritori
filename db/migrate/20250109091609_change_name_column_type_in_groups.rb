class ChangeNameColumnTypeInGroups < ActiveRecord::Migration[6.1]
  def change
    change_column :groups, :name, :string
  end
end
