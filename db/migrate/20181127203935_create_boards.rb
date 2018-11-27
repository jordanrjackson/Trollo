class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :chores_board
      t.string :work_board
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
