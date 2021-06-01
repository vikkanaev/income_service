class OperationsController < ApplicationController
  include PaginationLinks
  include OperationsTotalAmounts

  def index
    ops = Operations::FetchService.call(fetch_params).operations.page(params[:page])
    serializer = OperationSerializer.new(ops, index_options(ops))
    render json: serializer.serialized_json
  end

  def create
    result = Operations::CreateService.call(
      operation: op_params,
      user: current_user
    )

    if result.success?
      serializer = OperationSerializer.new(result.operation)
      render json: serializer.serialized_json, status: :created
    else
      error_response(result.operation, :unprocessable_entity)
    end
  end

  private

  def fetch_params
    { period_start: period_start, period_end: period_end, user: current_user }
  end

  def index_options(scope)
    operations_total_amounts(period_start, period_end, current_user).merge(pagination_links(scope))
  end

  def period_start
    str = params[:period_start]
    str.present? ? Date.parse(str) : Date.current
  end

  def period_end
    str = params[:period_end]
    str.present? ? Date.parse(str) : Date.current
  end

  def op_params
    params.require(:operation).permit(:description, :amount, :date)
  end
end
