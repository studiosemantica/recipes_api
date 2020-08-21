class Recipe < ApplicationRecord
  # model association
  belongs_to :category

  # validation
  validates_presence_of :name
end