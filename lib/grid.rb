require_relative 'block'

class Grid


	PUZZLE_EASY = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'

	attr_accessor :table, :row_reference, :column_reference

	def initialize puzzle=PUZZLE_EASY
		@puzzle = puzzle
		@table = Array.new(8) {Array.new(8)}
		@row_reference = 0
		@column_reference = 0
		@block_start_row_ref_points = [0,0,0,3,3,3,6,6,6]
		@block_start_col_ref_points = [0,3,6,0,3,6,0,3,6]
		@block_start_row_ref = @block_start_row_ref_points[0]
		@block_start_col_ref = @block_start_col_ref_points[0]
		@iterator = 0
		@block_array = []
		@rows = []
		@columns = []
		create_table
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

	def solve
		@block_start_row_ref = @block_start_row_ref_points[@iterator]
		@block_start_col_ref = @block_start_col_ref_points[@iterator]
		create_block_rows_columns_for_Block_class
		block = Block.new(@block_array, @rows, @columns)
		updated_block = block.solve
		update_values_in_the_table updated_block
		return print_table if puzzle_completed? 
		if @iterator == 8
			@iterator = 0
		else
			@iterator += 1
		end
		solve
	end

	def puzzle_completed?
		@table.select {|x| x=0}.count == 0
	end

	def update_values_in_the_table updated_block
		updated_block_row_ref = 0
		updated_block_col_ref = 0
		8.times do
			@table[@block_start_row_ref][@block_start_col_ref] = updated_block[updated_block_row_ref][updated_block_col_ref]
			move_to_the_next_cell_in_the_table 
				if updated_block_col_ref == 2
					updated_block_col_ref = 0
					if updated_block_row_ref != 2
						updated_block_row_ref += 1
					end
				else
					updated_block_col_ref += 1
				end
		end
	end

	def move_to_the_next_cell_in_the_table
		if @block_start_col_ref == 2
			@block_start_col_ref = 0
			if @block_start_row_ref != 2
				@block_start_row_ref += 1
			end
		else
			@block_start_col_ref += 1
		end
	end

	def create_block_rows_columns_for_Block_class
		@block_start_row_ref = 0
		@block_start_col_ref = 0
		@block_array = create_block_for_Block_class @block_start_row_ref, @block_start_col_ref
		@rows = create_rows_for_Block_class @block_start_row_ref
		@columns = create_columns_for_Block_class @block_start_col_ref
	end

	def create_block_for_Block_class starting_row, starting_column
		@block_array = []
		(starting_row..(starting_row+2)).each do |row_ref|
		@block_array << @table[row_ref][column_reference..(column_reference+2)]
		end
		@block_array
	end	

	def create_rows_for_Block_class starting_row
		@rows = []
		@rows = @table[starting_row..(starting_row+2)]
		@rows
	end

	def create_columns_for_Block_class starting_column
		@columns = []
		(0..8).each do |row_ref|
		@columns << @table[row_ref][starting_column..(starting_column+2)]
		end
		@columns
	end

	def print_table
		puts "Updated Grid"
		@table.each {|row| puts row.inspect}
		puts "row and col reference:"
		puts @block_start_row_ref 
		puts @block_start_col_ref
		puts @table.select {|x| x=0}.count
	end

end