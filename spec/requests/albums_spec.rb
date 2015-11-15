require 'rails_helper'
RSpec.describe "Albums", :type => :request do
  describe "GET /albums" do
    let(:data) { JSON.parse(response.body)["data"] }

    before do
      10.times { Album.create!(name: Faker::Lorem.sentence) }
      get albums_path
    end

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "returns all albums" do
      expect(data.length).to eq(10)
    end
  end
end
