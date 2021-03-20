module OperationHelper
  extend ActiveSupport::Concern

  class_methods do
    def formated_amount(operation)
      operation.amount.format
    end

    def formated_date(operation)
      operation.period.date.to_s
    end
  end
end
