module Periods
  class AmountTotalRecalculateService
    prepend BasicService

    param :period
    attr_reader :period

    def call
      @period.amount_total_cents = @period.operations.sum(:amount_cents)
      return fail!(@period.errors) unless @period.save!
    end
  end
end
