class Utilitydata < ActiveRecord::Base
  validates :state, presence: true
  validates :date, presence: true
  validates :amount, presence: true
  validates :kind, presence: true
end
