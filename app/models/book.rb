class Book < ApplicationRecord
  belongs_to :user
  enum status: { awaiting: 0, finished: 1, wip: 2 } 
  validates :author, :status, :category, presence: true
  validates :name, presence: true, uniqueness: true

  scope :books, -> (filters){ where("#{filters[:field]} = ?", filters[:value]) }

  before_validation(on: :create) do
    self.status = 0
  end
end
