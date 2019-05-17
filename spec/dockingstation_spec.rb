require 'dockingstation'
require 'bike'
require 'pry-byebug'


describe 'DockingStation' do
  let(:docking_station) { DockingStation.new }
  let(:bike) { double(:bike) }

  it 'shows class DockingStation exists' do
    expect(docking_station).to be_a_kind_of(DockingStation)
  end

  it 'responds to release_bike method' do
    expect(docking_station).to respond_to(:release_bike)
  end

  it 'can release bike from docking station' do
    allow(bike).to receive(:broken?).and_return(false)
    docking_station.dock(bike)
    expect(docking_station.release_bike).to eq(bike)
  end

  it 'releases working bikes' do
    allow(bike).to receive(:working?).and_return(true)
    allow(bike).to receive(:broken?).and_return(false)
    docking_station.dock(bike)
    expect(docking_station.release_bike).to be_working
  end

  it 'responds to dock_bike method' do
    expect(docking_station).to respond_to(:dock)
  end

  describe '#release' do
    it 'raises error if release bike on empty dock' do
      expect { docking_station.release_bike }.to raise_error 'No bikes available'
    end

    it 'raises error if bike is broken' do
      allow(bike).to receive(:broken?).and_return(true)
      allow(bike).to receive(:report_broken).and_return(:broken?)
      bike.report_broken
      docking_station.dock(bike)
      expect { docking_station.release_bike }.to raise_error 'This bike is broken'
    end
  end

  describe '#dock' do
    it 'raises error if dock is full' do
      docking_station.capacity.times { docking_station.dock(bike) }
      expect { docking_station.dock(bike) }.to raise_error 'Docking station full'
    end
  end

  describe '#initialization' do
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock(bike) }
      expect{ docking_station.dock(bike) }.to raise_error 'Docking station full'
    end
  end

end
