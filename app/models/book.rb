class Book < ApplicationRecord
  belongs_to :user
  enum status: { awaiting: 0, finished: 1, wip: 2 } 
  validates :name, presence: true, uniqueness: true
  validates :author, presence: true
  validates :status, presence: true

  before_save do
    self.status = 0
  end
end
