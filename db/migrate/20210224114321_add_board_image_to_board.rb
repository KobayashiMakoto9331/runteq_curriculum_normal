class AddBoardImageToBoard < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :Board_image, :string
  end
end
