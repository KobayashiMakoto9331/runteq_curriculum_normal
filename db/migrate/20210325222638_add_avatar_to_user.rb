class AddAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Avatar, :string
  end
end
