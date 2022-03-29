# В целом это очень страння идея писать тесты на рельсовые валидации в таком виде
# потому что они уже протестированны в самих rails
# но больше не на что, потому что модель тонкая
# так что этот тест призван просто продемонстрировать навык написания теста на модели

RSpec.describe Operation, type: :model do
  subject { described_class.new(user: user, period: period, description: description) }

  let(:user) { build(:user) }
  let(:period) { build(:period) }
  let(:description) { 'op description' }

  context 'when valid attributes' do
    it { expect(subject).to be_valid }
  end

  context 'when invalid user attribute' do
    let(:description) { nil }
    it { expect(subject).to_not be_valid }
  end

  context 'when invalid description attribute' do
    let(:description) { nil }
    it { expect(subject).to_not be_valid }
  end

  context 'when invalid period attribute' do
    let(:period) { nil }
    it { expect(subject).to_not be_valid }
  end
end
