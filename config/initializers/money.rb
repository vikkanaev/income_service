MoneyRails.configure do |config|
  config.default_currency = :rub
  config.locale_backend = nil
  config.rounding_mode = BigDecimal::ROUND_HALF_EVEN
end
