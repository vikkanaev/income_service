module Operations
  class FetchService
    prepend BasicService

    option :period_start
    option :period_end
    option :user

    attr_reader :operations

    def call
      @operations = Operation.joins(:period)
                             .where(periods: { date: @period_start..@period_end }, user: @user)
                             .order('periods.date')
    end
  end
end
