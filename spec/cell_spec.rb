require 'cell'

describe 'cell' do

	let(:cell) {Cell.new([0, 1, 5, 0, 0, 0, 2, 7, 0], [0, 1, 5, 0, 0, 3, 0, 0, 2], [0, 0, 2, 4, 5, 0, 9, 8, 0])}
	
	# it 'should check if cell is filled out' do
	# 	expect(cell.empty?).to eq false
	# end

    # it 'should if cell is empty' do
    # 	expect(cell.empty?).to be true
    # end

    it 'prints all the values' do
    	cell.solve
    	cell.print_values
	end

end
