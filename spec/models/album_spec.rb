# all spec files must require spec_helper to be able to run.
require 'spec_helper'

describe Album do
  #factory girl refactor allows to change from Album.new syntax to build below.
  subject(:album) {build(:album)}

  describe 'validation' do 
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      # testing to be_invalid so album.rb model requires line of validates_presence_of
      expect(subject).to be_invalid
    end

    it 'requires an image_url' do
      expect(subject).to be_valid
      subject.image_url = nil
      expect(subject).to be_invalid
    end
  end

  describe 'association' do
    it 'knows owning users' do
      # the line below forces to create has_and_belongs_to_many :users on model to pass test.
      expect(subject).to respond_to(:users)
    end

    it 'has songs' do
      expect(subject).to respond_to(:songs)
    end
  end
end




