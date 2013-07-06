require 'spec_helper'

describe ArtistsController do
  # to test the index using the HTTP request get
  describe 'collection' do
    describe 'GET #index' do
      it 'saves all artists as instance variables' do
        artist = create(:artist)
        artist2 = create(:artist2)
        get :index
        assigns(:artists).should eq [artist, artist2]
      end
      it 'renders the :index view' do
        get :index
        response.should render_template :index
      end
    end

    describe 'GET #new' do
      let(:artist){ mock_model(Artist).as_new_record }

      before do
        Artist.stub(:new).and_return(artist)
      end
      it 'saves a new artist as an instance variable' do
        get :new
        assigns(:artist).should be_an_instance_of(Artist)
        assigns(:artist).should be_new_record
      end
      it 'renders the :new view' do 
        get :new
        response.should render_template :new
      end
    end

    describe 'POST #create' do
      let(:artist) {mock_model(Artist).as_null_object}

      before do
        Artist.stub(:new).and_return(artist)
      end
      context 'when save succeeds' do
        it 'saves the artist' do
          # below saying artist.save needs to be called on controller
          artist.should_receive(:save)
          post :create
        end

        it 'redirects to artists index view' do
          post :create
          response.should redirect_to artists_path
        end
      end  

      context 'when save fails' do
        it 'renders new page' do
          artist.should_receive(:save).and_return(false)
          post :create
          response.should render_template 'new'
        end
      end 
    end
  end 
        # context 'with valid attributes' do
        #  it 'creates a new artist' do
        #   expect{
        #       post :create, artist: attributes_for(:artist)
        #     }.to change{ Artist.count }.by(1)
        # end
        # it 'redirects to artists index view' do
        #   post :create, artist: attributes_for(:artist)
        #   response.should redirect_to artists_path
        # end

        # context 'with invalid attributes' do
        #   it 'does not create a new artist' do
        #     expect{
        #       post :create, invalid_artist: attributes_for(:invalid_artist)
        #     }.to change{ Artist.count }.by(0)
        #   end
        #   it 'renders the :new view' do
        #     get :new
        #     response.should render_template :new
        #   end
      


  describe 'member' do
    let(:artist){ mock_model(Artist) }

    before do
      Artist.stub(:find).and_return(artist)
    end
    
    describe 'GET #edit' do
      before { get :edit, id: artist }
      it 'assigns an edited artist as an instance variable' do
        assigns(:artist).should eq artist
      end
      it 'renders the :edit view' do
        response.should render_template :edit
      end
    end

    describe 'GET #show' do
      before do
        # stubbing b/c calling to db. If no .find, no need for stub
        
        get :show, id: artist
      end 

      it 'assigns an edited artist as an instance variable' do
        assigns(:artist).should eq artist
      end
      it 'renders the :show view' do
        response.should render_template :show
      end
    end

    describe 'PUT #update' do
      # made a mock model at the top describe 'member' but these tests written for real model.
      # line below reinstantiates this test to test with real model. 
      let(:artist) {create :artist}
      context 'valid attributes' do
        let(:updated_artist){ build(:updated_artist) }
        it 'assigns the given artist to an instance variable' do
          put :update, id: artist, artist: attributes_for(:updated_artist)
          assigns(:artist).should eq artist
        end
        it 'changes the attributes of the artist' do 
          original_name = artist.name
          original_url = artist.url
          put :update, id: artist, artist: attributes_for(:updated_artist)
          artist.reload
          artist.name.should eq updated_artist.name
          artist.name.should_not eq original_name
          artist.url.should eq updated_artist.url
          artist.url.should_not eq original_url
        end
        it 'redirects to the artist path' do
          put :update, id: artist, artist: attributes_for(:updated_artist)
          response.should redirect_to artist_path
        end
      end

      context 'invalid attributes' do
        it 'assigns the given artist to an instance variable' do
          put :update, id: artist, artist: attributes_for(:invalid_artist)
          assigns(:artist).should eq artist
        end
        it 'does not change the attributes of the artist' do
          # this is my only test that doesn't pass and not sure why
          original_name = artist.name
          original_url = artist.url
          put :update, id: artist, artist: attributes_for(:invalid_artist)
          artist.reload
          artist.name.should eq original_name
          artist.name.should_not be_nil
          artist.url.should eq original_url
          artist.url.should_not be_nil
        end
        it 're-renders the edit page' do
          put :update, id: artist, artist: attributes_for(:invalid_artist)
          response.should render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:artist) {create :artist}
      it 'assigns the given artist to an instance variable' do
        delete :destroy, id: artist
        assigns(:artist).should eq artist
      end
      it 'deletes the artist' do
        expect {
          delete :destroy, id: artist
        }.to change { Artist.count }.by(-1)
      end
      it 'redirects to the artists index page' do
        delete :destroy, id: artist
        response.should redirect_to artists_path
      end
    end
  end
end
