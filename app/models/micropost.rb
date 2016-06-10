class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
<<<<<<< HEAD
  validates :content, presence: true, length: {maximum: 140}
=======
  validates :content, presence: true, length: { maximum: 140 }
>>>>>>> updating-users
end
