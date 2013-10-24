require 'grid'

describe "Grid" do


	let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600'} # it's an easy sudoku puzzle, row by row }
	let(:grid) {Grid.new}

	context "Grid initialisation" do

		it 'should have 81 cells' do
			expect(grid.cells_count).to eq 81
		end

		it 'should have an unsolved first cell' do
			grid.row_reference = 0
			grid.column_reference = 0
			expect(grid.cell_empty?).to eq true 
		end

		it 'should have a solved second cell with a value 1' do
			grid.row_reference = 0
			grid.column_reference = 1
			expect(grid.cell_empty?).to eq false
		end 

		it 'the last cell in the puzzle should be [8][8]of the array' do
			expect(grid.table[8][8]).to eq 0
		end

		it 'the last cell in the puzzle should be [1][3]of the array' do
			expect(grid.table[1][3]).to eq 1

		end

	end

	context "Grid solver" do

		it 'should create a block to be sent to the Block class' do
			expect(grid.create_block_for_Block_class(0, 0)).to eq [[0,1,5],[0,0,0],[2,7,0]]
		end

		it 'should create a set of rows to be sent to the Block class' do
			expect(grid.create_rows_for_Block_class(0)).to eq [[0, 1, 5, 0, 0, 3, 0, 0, 2],[0, 0, 0, 1, 0, 0, 9, 0, 6],[2, 7, 0, 0, 6, 8, 4, 3, 0]]
		end

		it 'should create a set of columns to be sent to the Block class' do
			expect(grid.create_columns_for_Block_class 0).to eq [[0, 1, 5],[0, 0, 0],[2, 7, 0],[4, 9, 0],[5, 0, 1],[0, 0, 3],[9, 0, 0],[8, 6, 0],[0, 3, 7]]
		end

		it 'prints all the values' do
			grid.solve
			grid.print_table
		end


		# it 'provides the block, rows and columns to the Block Class to solve' do
		# 	grid.solve
		# 	expect(grid.block).to receive(grid.block_array)
		# end

	end
end