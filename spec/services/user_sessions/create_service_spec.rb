RSpec.describe UserSessions::CreateService do
  subject { described_class }

  context 'valid parameters' do
    let!(:user) { create(:user, email: 'sam@example.com', password: 'qwerty') }

    it 'creates a new session' do
      expect { subject.call('sam@example.com', 'qwerty') }
        .to change { user.sessions.count }.from(0).to(1)
    end

    it 'assigns session' do
      result = subject.call('sam@example.com', 'qwerty')

      expect(result.session).to be_kind_of(UserSession)
    end
  end

  context 'missing user' do
    it 'does not create session' do
      expect { subject.call('sam@example.com', 'qwerty') }
        .not_to(change { UserSession.count })
    end

    it 'adds an error' do
      result = subject.call('sam@example.com', 'qwerty')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end

  context 'invalid password' do
    let!(:user) { create(:user, email: 'sam@example.com', password: 'qwerty') }

    it 'does not create session' do
      expect { subject.call('sam@example.com', 'invalid') }
        .not_to(change { UserSession.count })
    end

    it 'adds an error' do
      result = subject.call('sam@example.com', 'invalid')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end
end
