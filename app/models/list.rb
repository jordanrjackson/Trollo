class List < ApplicationRecord
  belongs_to :task
  belongs_to :board, optional:true
  belongs_to :user

  def info
    "#{self.name} - #{self.task.name}"
  end
end