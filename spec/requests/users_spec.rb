RSpec.describe 'Users API', type: :request do
  describe 'POST /signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/signup', params: { email: 'sam@example.com', password: '' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/signup', params: { email: 'sam@example.com', password: 'qwerty' }

        expect(response).to have_http_status(:created)
      end
    end
  end
end
