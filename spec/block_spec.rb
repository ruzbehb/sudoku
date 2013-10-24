require 'block'

	describe 'block' do

		let(:block) {Block.new([[0,1,5],[0,0,0],[2,7,0]], [[0, 1, 5, 0, 0, 3, 0, 0, 2],[0, 0, 0, 1, 0, 0, 9, 0, 6],[2, 7, 0, 0, 6, 8, 4, 3, 0]], [[0, 1, 5],[0, 0, 0],[2, 7, 0],[4, 9, 0],[5, 0, 1],[0, 0, 3],[9, 0, 0],[8, 6, 0],[0, 3, 7]])}
		let(:grid) {double :Grid}

		it 'receives a 3*3 block from the grid' do
			expect(block.block_array_count).to eq 9
		end

		it 'checks if its empty' do
			expect(block.empty_cell?).to eq true
		end

		it 'checks if its full' do
			block.column_reference = 1
			expect(block.empty_cell?).to eq false
		end

		it 'should return the block back to the grid when the block is completed', :thisone=>true do
			block.row_reference = 2
			block.column_reference = 2
			expect(block.solve).to eq block.block_array
		end

		it 'should move from one cell on another row if it reaches the end of the row' do
			block.row_reference = 0
			block.column_reference = 2
			block.move_to_the_next_cell
			expect(block.row_reference).to eq 1
			expect(block.column_reference).to eq 0
		end	

		it 'prints all the values' do
			block.solve
			block.print_array_values
		end

	end