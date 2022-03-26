RSpec.describe 'Operations', type: :request do
  before { Timecop.freeze(Time.local(1990)) }
  after { Timecop.return }

  describe 'GET /' do
    let(:user) { create(:user) }
    let(:period) { create(:period, user: user, date: Date.current) }
    let!(:operations) { create_list(:operation, 3, user: user, period: period) }

    it 'returns a collection of ads' do
      get '/', headers: auth_headers(user)

      expect(response).to have_http_status(:success)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /operations (valid auth token)' do
    let(:user) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        post '/operations', headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'invalid parameters' do
      let(:op_params) do
        {
          description: '',
          amount: 10.05,
          date: '2021-03-20'
        }
      end

      it 'returns an error' do
        post '/operations', headers: auth_headers(user), params: { operation: op_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include(
          {
            'detail' => 'не может быть пустым',
            'source' => {
              'pointer' => '/data/attributes/description'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:op_params) do
        {
          description: 'Op description',
          amount: 10.05,
          date: '2021-03-20'
        }
      end

      let(:last_op) { user.operations.last }

      it 'creates a new operation' do
        expect { post '/operations', headers: auth_headers(user), params: { operation: op_params } }
          .to change { user.operations.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns an operation' do
        post '/operations', headers: auth_headers(user), params: { operation: op_params }

        expect(response_body['data']).to a_hash_including(
          'id' => last_op.id.to_s,
          'type' => 'operation'
        )
      end
    end
  end

  describe 'POST /operations (invalid auth token)' do
    let(:op_params) do
      {
        description: 'Op description',
        amount: 10.05,
        date: '2021-03-20'
      }
    end

    it 'returns an error' do
      post '/operations', params: { operation: op_params }

      expect(response).to have_http_status(:forbidden)
      expect(response_body['errors']).to include('detail' => 'Доступ к ресурсу ограничен')
    end
  end
end
