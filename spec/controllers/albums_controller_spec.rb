require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do

  let(:valid_attributes)   { { :name => Faker::Lorem.sentence } }
  let(:invalid_attributes) { { :name => ""} }
  let(:valid_session)      { { } }

  describe "GET index" do
    it "responds with 200 OK" do
      3.times { Album.create! valid_attributes }
      get :index, { }, valid_session
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET show" do
    context "when the album exists" do
      let(:album) { Album.create!(valid_attributes) }

      it "responds with 200 OK" do
        album = Album.create! valid_attributes
        get :show, {:id => album.to_param}, valid_session
        expect(response).to have_http_status(:ok)
      end
    end

    context "when album doesn't exist" do
      it "responds with 404 Not Found" do
        get :show, {:id => Faker::Number.digit}, valid_session
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Album" do
        expect {
          post :create, {:album => valid_attributes}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "responds with 201 Created" do
        post :create, {:album => valid_attributes}, valid_session
        expect(response).to have_http_status(:created)
      end
    end

    describe "with invalid params" do
      before { post :create, {:album => invalid_attributes}, valid_session }

      it "responds with 422 Unprocessable Entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a list of errors" do
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end
  end

  describe "PATCH update" do
    let(:album) { Album.create! valid_attributes }

    describe "with valid params" do
      let(:new_name) { Faker::Lorem.sentence }

      before do
        patch :update, {:id => album.id, :album => { :name => new_name }}, valid_session
        album.reload
      end

      it "updates the requested album" do
        expect(album.name).to eq(new_name)
      end

      it "responds with 200 OK" do
        expect(response).to have_http_status(:ok)
      end
    end

    describe "with invalid params" do
      before { patch :update, {:id => album.id, :album => invalid_attributes}, valid_session }

      it "responds with 422 Unprocessable Entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a list of errors" do
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end
  end

  describe "DELETE destroy" do
    context "when the album exists" do
      before { 2.times { Album.create!(valid_attributes) } }

      it "destroys the requested album" do
        expect {
          delete :destroy, {:id => Album.last.id}, valid_session
        }.to change(Album, :count).by(-1)
      end

      it "responds with 204 No Content" do
        album = Album.create! valid_attributes
        delete :destroy, {:id => album.to_param}, valid_session
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the album doesn't exist" do
      it "responds with 404 Not Found" do
        delete :destroy, {:id => Faker::Number.digit}
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
