require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let :valid_attributes do
    FactoryBot.attributes_for(:user)
  end

  let :invalid_attributes do
    FactoryBot.attributes_for(:user).except(:email)
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(UserSerializer.new(User.last).to_json)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with the right error for the new user" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq({ error: ["Email can't be blank"] }.to_json)
      end
    end
  end

  # TODO: this test is failing for some reason...
  # Also, should this be a GET instead of a POST?
  describe "POST #get_user_by_id" do
    it "returns a success response" do
      user = User.create! valid_attributes
      post :get_user_by_id, params: { id: user.to_param }
      expect(response).to be_success
      expect(response.body).to eq(UserSerializer.new(User.last).to_json)
    end
  end

  describe 'POST #follow_trip_user' do
    let(:logged_in_user) { FactoryBot.create(:user) }
    let(:trip_user) { FactoryBot.create(:user) }
    let(:trip) do
      FactoryBot.create(:trip) do |t|
        t.update user: trip_user
      end
    end

    context 'when logged in' do
      before { login_as logged_in_user }

      it 'follows the user of the trip that is selected' do
        post :follow_trip_user, params: { trip_id: trip.to_param }
        expect(response).to have_http_status(:success)
        expect(logged_in_user.following).to include(trip_user)
        expect(trip_user.followers).to include(logged_in_user)
      end
    end

    context 'when not logged in' do
      it 'responds with unauthorized' do
        post :follow_trip_user, params: { trip_id: trip.to_param }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
