p @errors
json.errors(@errors) do |error|
  p error
  @errors[error].map do |message|
    json.field error
    json.message message
  end
end