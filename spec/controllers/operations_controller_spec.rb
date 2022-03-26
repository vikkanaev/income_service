RSpec.describe OperationsController, type: :controller do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  before do
    request.headers.merge!(headers)
    subject
  end

  describe 'GET index' do
    subject { get :index }

    context 'when user logged in' do
      it 'has a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'returns json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end
    end

    context 'when user not logged in' do
      let(:headers) { {} }

      it 'has a 403 status code' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST create' do
    subject { post :create, params: { operation: operation_params } }

    let(:operation_params) { { description: 'my op', amount: 1, date: '1971-01-01' } }

    context 'when valid params' do
      it 'has a 200 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'returns json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end
    end

    context 'when invalid params' do
      let(:operation_params) { {} }

      it 'has a 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'has error in body' do
        expect(response_body).to eq({ 'errors' => [{ 'detail' => 'В запросе отсутствуют необходимые параметры' }] })
      end
    end

    context 'when user not logged in' do
      let(:headers) { {} }

      it 'has a 403 status code' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
