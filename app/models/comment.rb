class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :user_id, presence: true
  validated :playlist_id, presence: true
end
