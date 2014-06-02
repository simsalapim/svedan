json.array!(@ords) do |ord|
  json.extract! ord, :english, :swedish, :last_shown_at
  json.attempt_count ord.attempts.count
  json.failed_attempts ord.failed_attempts.count
  json.successful_attempts ord.successful_attempts.count
  json.success_ratio ord.success_ratio
  json.url ord_url(ord, format: :json)
end
