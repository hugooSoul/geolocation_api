require 'rails_helper'

RSpec.describe GeolocationsController, type: :controller do
  let(:valid_attr) { {ip_or_url: '134.201.250.155'} }
  let(:invalid_attr) { {ip_or_url: 'invalid'} }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Geolocation' do
        expect {
          post :create, params: valid_attr
        }.to change(Geolocation, :count ).by (1)
      end

      it 'renders a JSON response with the Geolocation info' do
        post :create, params: valid_attr

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON with errors' do
        post :create, params: invalid_attr

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
