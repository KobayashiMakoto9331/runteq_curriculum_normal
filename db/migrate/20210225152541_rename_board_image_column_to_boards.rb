class RenameBoardImageColumnToBoards < ActiveRecord::Migration[5.2]
  def change
    rename_column :boards, :Board_image, :board_image
  end
end
