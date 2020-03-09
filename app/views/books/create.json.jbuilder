if @book.errors.any?
  json.ok false
  json.err @book.errors
else
  json.ok true
  json.user do
    json.id @book.id
    json.name @book.name
    json.author @book.author
    json.status @book.status
    json.user_id @book.user_id
  end
end
