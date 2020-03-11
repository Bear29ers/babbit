class Habit < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :habit, presence: true, uniqueness: {case_sensitive: false}
end
