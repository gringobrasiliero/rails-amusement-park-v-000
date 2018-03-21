class Ride < ActiveRecord::Base
  # write associations here
  validates :user_id, presence: true
  validates :attraction_id, presence: true

  belongs_to :user
  belongs_to :attraction
end
