json.ok true
json.status 200
json.user do
  json.id @current_user.id
  json.username @current_user.username
  json.email @current_user.email
  json.first_name @current_user.first_name
  json.last_name @current_user.last_name
end
