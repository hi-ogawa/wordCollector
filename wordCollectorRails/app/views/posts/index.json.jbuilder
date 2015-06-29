json.array!(@posts) do |post|
  json.extract! post, :id, :word, :sentence, :picture
  json.url post_url(post, format: :json)
end
