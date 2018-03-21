class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :happiness, :string
        remove_column :users, :nausea, :string
        add_column :users, :happiness, :integer
        add_column :users, :nausea, :integer
  end
end
