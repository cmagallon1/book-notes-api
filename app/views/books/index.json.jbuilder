json.ok true
json.status 200
json.books @books do |book|
  json.id book.id
  json.name book.name
  json.author book.author
  json.status book.status
  json.user_id book.user_id
  json.category book.category
end
