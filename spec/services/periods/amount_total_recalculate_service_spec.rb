RSpec.describe Periods::AmountTotalRecalculateService do
  subject { described_class.call(period1).period }

  let(:date1) { Date.parse('2021-03-20') }
  let(:date2) { Date.parse('2021-03-21') }
  let(:period1) { create(:period, date: date1) }
  let(:period2) { create(:period, date: date2) }
  let!(:op1) { create(:operation, period: period1) }
  let!(:op2) { create(:operation, period: period1) }
  let!(:op3) { create(:operation, period: period2) }

  it 'returns sums of operations in selected period' do
    expect(subject.amount_total).to eq(op1.amount + op2.amount)
  end
end
