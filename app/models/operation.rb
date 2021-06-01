class Operation < ApplicationRecord
  monetize :amount_cents

  belongs_to :user
  belongs_to :period

  validates :description, presence: true
end
