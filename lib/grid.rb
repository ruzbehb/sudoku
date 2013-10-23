require_relative 'block'

class Grid

	PUZZLE_EASY = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'

	attr_accessor :table, :row_reference, :column_reference

	def initialize puzzle=PUZZLE_EASY
		@puzzle = puzzle
		@table = Array.new(8) {Array.new(8)}
		@block_array = []
		@row_reference = 0
		@column_reference = 0
		create_table
		solve
	end

	def cells_count 
	  @table.count * @table[0].count
	end

	def cell_empty?
	  @table[@row_reference][@column_reference] == 0
	end 

	def create_table
	  @table = @puzzle.split(//).map { |s| s.to_i}.each_slice(9).to_a
	end

	def print_table
		@table.each {|row| puts row.inspect}
	end

	def create_block_for_Block_class starting_row, starting_column
		@block_array = []
		(starting_row..(starting_row+2)).each do |row_ref|
		@block_array << @table[row_ref][column_reference..(column_reference+2)]
		end
		@block_array
	end	

	def solve
		block_row_ref = 0
		block_col_ref = 0
		create_block_for_Block_class block_row_ref, block_col_ref
		block = Block.new 
		block.solve @block_array
		#loop and break when solved
		#get the updated block back 
	end

end