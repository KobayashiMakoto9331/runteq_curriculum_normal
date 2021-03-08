class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email, uniqueness: true, presence: true
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  # validates :password, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy

  def own?(object)
    id == object.user_id
  end

  def own_board?(board)
    self.id == board.user_id
  end
end
