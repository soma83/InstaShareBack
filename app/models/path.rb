class Path < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :size, numericality: { greater_than: 0 }, presence: true

  has_one_attached :file_element, dependent: :destroy

  belongs_to :user
end
