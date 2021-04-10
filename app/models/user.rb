class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email, uniqueness: true, presence: true
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  # validates :password, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :Avatar, AvatarUploader

  def own?(object)
    id == object.user_id
  end

  def bookmark(board)
    bookmarks_boards << board
  end

  def unbookmark(board)
    bookmarks_boards.delete(board)
  end

  def bookmark?(board)
    bookmarks_boards.include?(board)
  end

  enum role:
  {
    general: 0,
    admin: 1
  }
end
