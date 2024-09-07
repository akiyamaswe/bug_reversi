# frozen_string_literal: true
require 'debug'
class Position
  # マスを'f3','d6'などの表記で表現する。変数名cell_refとして取り扱う。
  COL = %w[a b c d e f g h].freeze
  ROW = %w[1 2 3 4 5 6 7 8].freeze

  DIRECTIONS = [
    TOP_LEFT      = :top_left,
    TOP           = :top,
    TOP_RIGHT     = :top_right,
    LEFT          = :left,
    RIGHT         = :right,
    BOTTOM_LEFT   = :bottom_left,
    BOTTOM        = :bottom,
    BOTTOM_RIGHT  = :bottom_right
  ].freeze

  attr_accessor :row, :col

  def initialize(row_or_cell_ref, col = nil)
    if col
      # Position.new(1, 5) のような呼び出し
      @row = row_or_cell_ref
      @col = col
    else
      # Position.new('f7')のような呼び出し
        #indexが入る
      @row = ROW.index(row_or_cell_ref[1])
      @col = COL.index(row_or_cell_ref[0])
    end
  end
  #何も入っていなかったらnilで真を返す
  def invalid?
    row.nil? || col.nil?
  end
  #ボードの範囲外（8かけ8マスの外）であれば真を変える
  def out_of_board?
    !((0..7).cover?(row) && (0..7).cover?(col))
  end
  #ボード外でなければ、盤面内の石の配置の色の値を返す
  def stone_color(board)
    return nil if out_of_board?

    board[row][col]
  end

  def to_cell_ref
    return '盤面外' if out_of_board?

    "#{COL[col]}#{ROW[row]}"
  end

  def next_position(direction)
    case direction
    when TOP_LEFT     then Position.new(row - 1, col - 1)
    when TOP          then Position.new(row - 1, col)
    when TOP_RIGHT    then Position.new(row - 1, col + 1)
    when LEFT         then Position.new(row,     col - 1)
    when RIGHT        then Position.new(row,     col + 1)
    when BOTTOM_LEFT  then Position.new(row + 1, col - 1)
    when BOTTOM       then Position.new(row + 1, col)
    when BOTTOM_RIGHT then Position.new(row + 1, col + 1)
    else raise 'Unknown direction'
    end
  end
end
