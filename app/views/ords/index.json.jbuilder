json.array!(@ords) do |ord|
  json.extract! ord, :english, :swedish, :shown_at, :failure_count, :show_count
  json.url ord_url(ord, format: :json)
end
