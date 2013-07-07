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
    
    it 'displays a table of artist names' do 
      visit artists_path
      save_and_open_page
      find('th').should have_content('Artist Names')
      page.should have_selector('table td') 
    end

    it 'links each artist name to that artists show page' do
      visit artists_path
      page.should have_selector('table td')
      # how do i put a variable within here. "#{artist.name} doesn't work"
      # click_link("#{artist.name}")
      page.should have_selector('table a')
    end
  
    it 'displays a link to delete artists' do
      visit artists_path
      page.should have_link('delete')
      click_link('delete')
      (Artist.count).should eq 1
    end

    it 'displays a link to edit an artist' do
      visit artists_path
      page.should have_link('edit')
      click_link('edit')
      find('h3').should have_content('Edit an Artist')
    end
  end

  describe 'edit artist page' do
    it 'can edit the attributes for an instance of artist' do
      visit edit_artist_path
      page.should have_selector('form#edit_artist')
      within('form#edit_artist') do
        fill_in 'Name', with: 'Queen'
        fill_in 'Url', with: 'HTTP://Queen.com'
        page.should have_selector('input[type=submit]')
        click_button('Edit Artist')
      end
      current_path.should eq artists_path
    end
  end

  describe 'GET artist/show' do
    context 'from artists#index view' do
      it 'displays an artists info' do
        visit artists_path
        page.should have_selector('table a')
        # click_link("#{artist.name}")
        visit artist_path
        save_and_open_page
        find('h3').should have_content('Artist URL')
      end
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