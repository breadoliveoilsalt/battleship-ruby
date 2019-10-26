class Coordinate

  attr_reader :row, :column

  def with_row(row)
    @row = row
    self
  end

  def with_column(column)
    @column = column
    self
  end

end
