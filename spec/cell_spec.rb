require 'cell'

describe 'cell' do

	let(:cell) {Cell.new}
	
	it 'should check if cell is filled out' do
		expect(cell.empty?).to eq false
	end

    # it 'should if cell is empty' do
    # 	expect(cell.empty?).to be true
    # end
end
