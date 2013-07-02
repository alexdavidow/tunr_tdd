require 'spec_helper'

describe Artist do
  subject(:artist) {Artist.new(name: 'Queen', url: 'queen.com')}

  describe 'validation' do
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'requires a url' do
      expect(subject).to be_valid
      subject.url = nil
      expect(subject).to be_invalid
    end
  end

  describe 'association' do
    it 'has songs' do
      expect(subject).to respond_to(:songs)
    end
  end
end
