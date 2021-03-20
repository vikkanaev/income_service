module OperationsTotalAmounts
  def operations_total_amounts(period_start, period_end, user)
    amounts = {
      start_total_amount: start_total_amount(period_start, user),
      end_total_amount: end_total_amount(period_end, user)
    }

    { meta: amounts }
  end

  private

  def start_total_amount(date, user)
    period = fetch_period(date, user).first
    amount_for(period)
  end

  def end_total_amount(date, user)
    period = fetch_period(date, user).last
    amount_for(period)
  end

  def fetch_period(date, user)
    user.periods.where('date <= ?', date).order(:date)
  end

  def amount_for(period)
    period.present? ? period.amount_total.format : Money.new(0).format
  end
end
