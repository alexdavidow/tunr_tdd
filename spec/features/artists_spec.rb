require 'spec_helper'

describe 'Artists' do
  before(:each) do
    create(:artist)
    create(:artist2)
  end

  describe 'navigation from home page' do
    it 'displays link to artist index view' do
      visit root_path
      find('h1').should have_content('HOME')
      click_link('Artists')
      find('h1').should have_content('Artists')
    end
  end

  describe 'list all instances of artist on index view' do
    
    # I know I have more tests to write, but I wanted to make sure I had the haml code right first.
    it 'displays a table of artist names' do 
      visit artists_path
      find('th').should have_content('Artist') 
    end
  end

  describe 'GET artist/new' do
    context 'from artists#index view' do
      it 'displays link to artist new view' do
        visit artists_path
        find('h1').should have_content('Artists')
        click_link('New Artist')
        find('h3').should have_content('New Artist')
      end
    end
  end

  describe 'New Artist page' do
    it 'can create a new instance of artist' do
      visit new_artist_path
      page.should have_selector('form#new_artist')
      within('form#new_artist') do
        fill_in 'Name', with: 'Prince'
        fill_in 'Url', with: 'HTTP://Prince.com'
        page.should have_selector('input[type=submit]')
        click_button('Create Artist')
      end
      current_path.should eq artists_path
      (Artist.count).should eq 3
    end
  end
end