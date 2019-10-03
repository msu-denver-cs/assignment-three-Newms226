class Car < ApplicationRecord
  belongs_to :make
  has_and_belongs_to_many :parts

  validates :vin, presence: true, numericality: true, uniqueness: true
  validates :model, presence: true
  validates :make_id, presence: true
end
