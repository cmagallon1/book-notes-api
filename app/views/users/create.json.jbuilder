json.ok true
json.status 201
json.user do
  json.id @user.id
  json.username @user.username
  json.email @user.email
  json.first_name @user.first_name
  json.last_name @user.last_name
end
