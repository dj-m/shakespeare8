class Sudoku
  def initialize(board_string)
    @board = board_string
  end

  def row(row)
    start_index = 9 * row

    @board[start_index...(start_index + 9)].split('')

  end

  def col(col)
      (0...9).map do |row|
        get(row, col)
      end
  end

  def box(row, col)

    b_row,b_col = (row/3)*3, (col/3)*3

    (b_row...(b_row + 3)).map do |r|
      (b_col...(b_col + 3)).map do |c|
        get(r,c)
      end
    end.flatten
  end

  def get(row, col)
    @board[col + 9 * row]
  end

  def won?
  ! @board.include?('-')
  end

  def valid?(arr)
    arr = dash_dashes(arr)
    arr == arr.uniq
  end

  def violation?
    (0...9).each do |coord|
      return true unless valid?(row(coord))
      return true unless valid?(col(coord))
    end

    (0...9).each do |b_row|
      (0...9).each do |b_col|
        return true unless valid?(box(b_row,b_col))
      end
    end
    false
  end


  def solve(board = @board)
    @board = board
    return false if violation?
    return board if won?

    (1..9).each do |num|
      solution = solve(board.sub('-',num.to_s))
      return solution if solution
    end

    false
  end

  def dash_dashes(arr)
    arr.reject{|i| i == "-"}
  end

  def to_s
    @board.split('').each_slice(9).to_a.map {|row| row.join("") }.join("\n")
  end

end