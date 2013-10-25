require_relative 'block'

class Grid

	PUZZLE_EASY = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'

	attr_reader :table, :row_reference, :column_reference

	def initialize puzzle=PUZZLE_EASY
		@puzzle = puzzle
		@table = []
		@new_table =  Array.new(9) {Array.new(9)}
		@row_reference = 0
		@column_reference = 0
		@block_start_row_ref_points = [0,0,0,3,3,3,6,6,6]
		@block_start_col_ref_points = [0,3,6,0,3,6,0,3,6]
		@block_start_row_ref 
		@block_start_col_ref 
		@iterator = 0
		@block_array = []
		@rows = []
		@columns = []
		@updated_block = []
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
		while (!puzzle_completed?) do
			iterator = 0
			9.times do
				@block_start_row_ref = @block_start_row_ref_points[iterator]
				@block_start_col_ref = @block_start_col_ref_points[iterator]
				create_block_rows_columns_for_Block_class
				puts "empty cells in a block"
				puts empty_cells_count(@block_array) 
				# if (empty_cells_count(@block_array) !=0)
				block = Block.new(@block_array, @rows, @columns)
				@updated_block = block.solve
				update_values_in_the_table 
				# end
				puts "iterator"
				puts iterator
				print_table
				puts "break"
				iterator += 1
				# check for whether the block has any zero values
				# solve if !puzzle_completed?
			end
			@table = @new_table
			@new_table =  Array.new(9) {Array.new(9)}
			puts "after transfer"
			print_table
		end
	end

	def puzzle_completed?
		puts "puzzle completed"
		puts empty_cells_count(@table)
		(empty_cells_count(@table) == 0)
	end

	def empty_cells_count array
		number_of_rows = array.count
		zero_count = 0
		(0..(number_of_rows-1)).each do |row|
			zero_count = zero_count + array[row].select {|x| x	== 0}.count
		end
		zero_count
	end

	def update_values_in_the_table
		updated_block_row_ref = 0
		updated_block_col_ref = 0
		9.times do
			@new_table[@block_start_row_ref][@block_start_col_ref] = @updated_block[updated_block_row_ref][updated_block_col_ref]
				move_to_the_next_cell_in_the_table 
				if updated_block_col_ref == 2
					updated_block_col_ref = 0
					updated_block_row_ref += 1
				else
					updated_block_col_ref += 1
				end
		end
	end

	def move_to_the_next_cell_in_the_table

		if @block_start_col_ref == 2
			@block_start_col_ref = 0
			@block_start_row_ref += 1
		elsif @block_start_col_ref == 5
			@block_start_col_ref = 3
			@block_start_row_ref += 1
		elsif @block_start_col_ref == 8
			@block_start_col_ref = 6
			@block_start_row_ref += 1
		else
			@block_start_col_ref += 1
		end
	end

	def create_block_rows_columns_for_Block_class
		create_block_for_Block_class @block_start_row_ref, @block_start_col_ref
		create_rows_for_Block_class @block_start_row_ref
		create_columns_for_Block_class @block_start_col_ref
	end

	def create_block_for_Block_class starting_row, starting_column
		@block_array = []
			(starting_row..(starting_row+2)).each do |row_ref|
			@block_array << @table[row_ref][starting_column..(starting_column+2)]
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
		puts "original table"
		@table.each {|row| puts row.inspect}
		puts "new table"
		@new_table.each {|row| puts row.inspect}
	end

end