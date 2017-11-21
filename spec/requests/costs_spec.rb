require 'rails_helper'

RSpec.describe 'Costs API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:costs) { create_list(:cost, 10, user_id: user.id) }
  let(:cost_id) { costs.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /costs
  describe 'GET /costs' do
    # make HTTP get request before each example
    before { get '/costs', params: {}, headers: headers }

    it 'returns costs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /costs/:id
  describe 'GET /costs/:id' do
    before { get "/costs/#{cost_id}", params: {}, headers: headers}

    context 'when the record exists' do
      it 'returns the cost' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(cost_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cost_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cost/)
      end
    end
  end

  # Test suite for POST /costs
  describe 'POST /costs' do
    # valid payload
    let(:valid_attributes) do
      { title: 'Mobile Vikings', description: 'Monthly cell phone costs', code: 'MV', amount: 15.0, paid: false, user_id: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/costs', params: valid_attributes, headers: headers }

      it 'creates a cost' do
        expect(json['title']).to eq('Mobile Vikings')
        expect(json['description']).to eq('Monthly cell phone costs')
        expect(json['code']).to eq('MV')
        expect(BigDecimal(json['amount'])).to be_same_number_as(15.0)
        expect(json['paid']).to eq(false)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/costs', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank, Description can't be blank, Code can't be blank, Amount can't be blank, Amount is not a number/)
      end
    end
  end

  # Test suite for PUT /costs/:id
  describe 'PUT /costs/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/costs/#{cost_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /costs/:id
  describe 'DELETE /costs/:id' do
    before { delete "/costs/#{cost_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end