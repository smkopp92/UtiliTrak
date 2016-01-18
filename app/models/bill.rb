class Bill < ActiveRecord::Base
  belongs_to :household

  validates :amount, presence: true
  validates :date, presence: true
  validates :kind, presence: true
end
