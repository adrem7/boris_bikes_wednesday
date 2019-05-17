require 'bike'
require 'pry-byebug'

describe 'Bike' do
  let(:bike) { Bike.new }

  it 'shows class Bike exists' do
    expect(bike).to be_a_kind_of(Bike)
  end

  it 'can be reported broken' do
    bike.report_broken
    expect(bike).to be_broken
  end
end
