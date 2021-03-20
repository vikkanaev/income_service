RSpec.describe OperationSerializer do
  subject { described_class.new([operation], links: links) }

  let(:operation) { create(:operation) }

  let(:links) do
    {
      first: '/path/to/first/page',
      last: '/path/to/last/page',
      next: '/path/to/next/page'
    }
  end

  it 'returns ad representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: [
        {
          id: operation.id.to_s,
          type: :operation,
          attributes: {
            amount: operation.amount.format,
            date: operation.period.date.to_s,
            description: operation.description
          }
        }
      ],
      links: links
    )
  end
end
