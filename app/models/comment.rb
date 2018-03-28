class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :playlist, counter_cache: true

  validates :user_id, presence: true
  validates :playlist_id, presence: true
end
