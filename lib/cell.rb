class Cell

  def initialize(block_selected, row_selected, column_selected)
  	@block_selected = block_selected
  	@row_selected = row_selected
  	@column_selected = column_selected
    @standard_list = (1..9).to_a
    @candidate = []
  end

  def solve 
	@candidate = @standard_list - @block_selected - @row_selected - @column_selected
	return @candidate[0] if @candidate.count == 1
	return [0] 
  end

  def print_values
  	puts "Candidate"
  	print @candidate
  end

end