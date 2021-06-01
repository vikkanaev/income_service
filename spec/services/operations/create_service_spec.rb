RSpec.describe Operations::CreateService do
  subject { described_class.call(operation: op_params, user: user) }

  let(:user) { create(:user) }

  context 'valid parameters' do
    let(:op_params) do
      {
        description: 'Op description',
        amount: 10.05,
        date: '2021-03-20'
      }
    end

    it 'creates a new operation' do
      expect { subject }.to change { user.operations.count }.from(0).to(1)
    end

    it 'assigns operation' do
      expect(subject.operation).to be_kind_of(Operation)
    end

    it 'enqueues recalculating job' do
      ActiveJob::Base.queue_adapter = :test
      subject

      expect(Periods::RecalculatingJob).to have_been_enqueued.with(kind_of(Period))
    end
  end

  context 'invalid parameters' do
    let(:op_params) do
      {
        description: 'Op description',
        amount: 10.05,
        date: ''
      }
    end

    it 'does not create operation' do
      expect { subject }.not_to(change { Operation.count })
    end

    it 'assigns errors' do
      expect(subject.errors).to eq(['Невозможно обработать переданные параметры'])
    end

    it 'does not enqueue geocoding job' do
      ActiveJob::Base.queue_adapter = :test
      subject

      expect(Periods::RecalculatingJob).not_to have_been_enqueued.with(kind_of(Period))
    end
  end
end
