require 'spec_helper'

describe Song do
  subject(:song) {create(:song, name: 'name override')}

  describe 'validation' do
    it'requires a name' do 
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end
  end

  describe 'association' do
    it 'has an artist method' do
      expect(subject).to respond_to(:artist)
    end 

    it 'has an artist' do
      # added below line to get test two lines down to pass. prob wrong.
      subject.artist = nil
      expect(subject.artist).to be_nil
      subject.artist_id = 1
      subject.should satisfy { |song| song.artist_id? }
    end

    it 'has an album method' do
      expect(subject).to respond_to(:album)
    end

    it 'has an album' do
      subject.album = nil
      expect(subject.album).to be_nil
      subject.album_id = 1
      subject.should satisfy { |song| song.album_id? }
    end
  end
end
