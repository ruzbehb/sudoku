require_relative 'cell'

class Block


	attr_accessor :block_array, :column_reference, :row_reference

	def initialize(block_array, rows, columns)
		@block_array = block_array
		@rows = rows
		@columns = columns
		@row_reference = 0
		@column_reference = 0
		@block_selected = []
	end	

	def block_array_count
		@block_array.count * @block_array[0].count
	end

	def solve
		9.times do
		select_relevant_block_row_column
		cell = Cell.new(@block_selected, @row_selected, @column_selected)
		updated_cell_value = cell.solve 
		update_block_row_column updated_cell_value
		# return @block_array if block_completed?
		i = 1
		while (!empty_cell? and i<10)
			move_to_the_next_cell
			i += 1
		end
		# solve
		end
		@block_array
	end

	def empty_cell?
		@block_array[@row_reference][@column_reference] == 0
	end

	def block_completed?
		@row_reference == 3
	end

	def move_to_the_next_cell
		if @column_reference == 2
			@column_reference = 0
			if @row_reference != 2
				@row_reference += 1
			end
		else
			@column_reference += 1
		end
	end

	def select_relevant_block_row_column
		@block_selected = @block_array.flatten
		@row_selected = select_relevant_row
		@column_selected = select_relevant_column
	end

	def select_relevant_row
		@rows[@row_reference]
	end

	def select_relevant_column
		selection = []
		(0..8).each do |row_ref|
			selection << @columns[row_ref][@column_reference]
		end
		selection
	end	

	def update_block_row_column updated_cell_value
		@block_array[@row_reference][@column_reference] = updated_cell_value
		@rows[@row_reference][@column_reference] = updated_cell_value
		@columns[@row_reference][@column_reference] = updated_cell_value
	end

	def print_array_values
		puts "flatten block"
		print @block_array
		puts "relevant row"
		print @rows
		puts "relevant column"
		print @columns
	end

end