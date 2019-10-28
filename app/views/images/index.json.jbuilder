json.images(@images) do |image|
  json.height image.height
  json.width image.width
  json.url image_url(image)
end