# frozen_string_literal: true
json.array!(@photos) do |photo|
  json.title photo[:title]
  json.url photo[:url]
end
