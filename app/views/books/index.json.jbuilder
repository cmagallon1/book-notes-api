if !@books
  json.ok false
  json.err "No books of that user"
else
  json.ok true
  json.books @books do |book|
    json.id book.id
    json.name book.name
    json.author book.author
    json.status book.status
    json.user_id book.user_id
    json.category book.category
  end
end
