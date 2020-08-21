class Category < ApplicationRecord
  # model association
  has_many :recipes, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end