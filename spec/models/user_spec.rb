require 'spec_helper'

describe User do
  subject(:user) {User.create(name: 'alex', email: 'alex@nder.com')}
  # when describing a method that is a behavior, start it with a # in rspec.

  describe '#purchase' do
    context 'for new album' do
      it 'adds an album to collection' do
        # works bc of factory girl implementation
        album = create(:album)
        lambda {
          subject.purchase(album)
        }.should change{user.albums.size}.by 1
        user.albums.should eq [album]
      end
    end

    context 'for existing album' do
      it 'does not add album to collection' do
        album = create(:album)
        subject.albums = [album]
        lambda {
          subject.purchase(album)
        }.should change{user.albums.size}.by 0
        user.albums.should eq [album] 
      end
    end
  end

  describe '#forget_albums' do
    it 'empties an array of albums' do
      subject.albums.size.should eq 0
    end
  end
end
