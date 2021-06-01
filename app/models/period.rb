class Period < ApplicationRecord
  monetize :amount_total_cents

  belongs_to :user
  has_many :operations
end
