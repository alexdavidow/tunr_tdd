require 'spec_helper'

describe 'Genre' do
  subject(:genre) {Genre.create(name: 'reggae')}

 describe 'validation' do
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end
  end


  describe 'association' do
    it 'has songs' do
      expect(subject).to respond_to(:songs)
    end
  end
end
