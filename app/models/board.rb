class Board < ApplicationRecord
  belongs_to :user

  # Instance Method
  # board = { first_name: "Jordan", last_name: "Jackson" }
  # board.full_name
  def full_name
    # "#{self.first_name} #{self.last_name}"
    board = Board.find_by_sql(["
      SELECT name
      FROM boards AS b
      WHERE b.id = ?
    ", self.id]).first

    "#{board.name@board}"
  end

  # Model Method
  # Board.all_boards
  def self.all_boards(board_id)
    Board.find_by_sql(["
      SELECT *
      FROM boards AS b
      WHERE b.user_id = ?
    ", board_id])
  end

  # def self.all_boards(user_id)
  #   Board.find_by_sql("
  #     SELECT *
  #     FROM boards AS b
  #     WHERE b.user_id = #{user_id}
  #   ")
  # end

  def self.single_board(user_id, board_id)
    Board.find_by_sql(["
      SELECT * 
      FROM boards AS b
      WHERE b.user_id = ? AND b.id = ?
    ;", user_id, board_id]).first
  end

  def self.create_board(p, user_id)
    Board.find_by_sql(["
      INSERT INTO boards (name, user_id, created_at, updated_at)
      VALUES (:name, :user_id, :created_at, :updated_at)
    ;", {
      name: p[:name],
      user_id: user_id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    }])
  end

  def self.update_board(p, board_id, user_id)
    Board.find_by_sql(["
      UPDATE boards AS b
      SET name = ?, updated_at = ?
      WHERE b.id = ? AND b.user_id = ?
    ", p[:name], DateTime.now, board_id, user_id])
  end

  def self.delete_board(user_id, board_id)
    Board.find_by_sql(["
      DELETE FROM boards AS b
      WHERE b.user_id = ? AND b.id = ?
    ", user_id, board_id])
  end

end