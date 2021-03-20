module Periods
  class RecalculatingJob < ApplicationJob
    queue_as :default

    def perform(period)
      Periods::AmountTotalRecalculateService.call(period)
    end
  end
end
