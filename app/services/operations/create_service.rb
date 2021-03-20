module Operations
  class CreateService
    prepend BasicService

    option :operation do
      option :description
      option :amount
      option :date
    end

    option :user

    attr_reader :operation

    def call
      return fail!(I18n.t(:argument_error, scope: 'api.errors')) unless op_date

      ActiveRecord::Base.transaction do
        @period = Period.find_or_create_by(user: @user, date: op_date)
        @operation = @period.operations.new op_params
        return fail!(@operation.errors) unless @operation.save
      end

      Periods::RecalculatingJob.perform_later(@period)
    end

    private

    def op_params
      @operation.to_h.symbolize_keys.slice(:description, :amount).merge(user: @user)
    end

    def op_date
      Date.parse(@operation.to_h['date'])
    rescue ArgumentError
      nil
    end
  end
end
