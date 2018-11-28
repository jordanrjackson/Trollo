class List < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :priority

end