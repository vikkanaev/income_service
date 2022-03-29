RSpec.describe 'Login and Post scenario', type: :request do
  let(:date) { Date.current.iso8601 }
  let(:email) { 'me@tezd.net' }
  let(:password) { '123qwe' }
  let!(:user) { create :user, email: email, password: password }

  let(:op_params) do
    {
      description: 'Op description',
      amount: 10.05,
      date: date
    }
  end

  it 'allows user to login, post and see result' do
    expect { post '/login', params: { email: email, password: password } }
      .to change { user.sessions.count }.by(+1)

    expect(response).to have_http_status(:success)
    expect(response_body['meta'].keys).to eq(['token'])

    token = response_body.dig('meta', 'token')

    expect { post '/operations', headers: header_for_token(token), params: { operation: op_params } }
      .to change { user.operations.count }.by(+1)

    expect(response).to have_http_status(:created)

    get '/', headers: header_for_token(token)

    expect(response).to have_http_status(:success)
    expect(response_body['data'].size).to eq(1)

    expect(response_body['data'].last).to include(
      {
        'type' => 'operation', 'attributes' => { 'description' => 'Op description', 'amount' => '10.05 ₽', 'date' => date }
      }
    )
  end
end
