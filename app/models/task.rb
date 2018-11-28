class Task < ApplicationRecord
  belongs_to :board
  belongs_to :user
  has_many :lists, dependent: :destroy
  validates_presence_of :name
end