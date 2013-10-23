require 'block'

	describe 'block' do
		
		let(:block) {Block.new :block_array}

		it 'receives a 3*3 block from the grid' do
			expect(block.block_array.count).to eq 9
		end

		it ''

	end