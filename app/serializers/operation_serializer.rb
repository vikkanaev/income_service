class OperationSerializer
  include FastJsonapi::ObjectSerializer
  include OperationHelper

  attribute :description

  attribute :amount do |operation|
    formated_amount(operation)
  end

  attribute :date do |operation|
    formated_date(operation)
  end
end
