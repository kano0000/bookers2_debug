class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :message, prresence: true, length: { maximum: 140 }
end
