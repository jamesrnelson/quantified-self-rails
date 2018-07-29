class Food < ApplicationRecord
  validates :name, presence: true
  validates :calories, presence: true
  has_many :meal_foods

  before_save :capitalize_name

  def capitalize_name
    self.name = self.name.downcase.capitalize
  end
end
