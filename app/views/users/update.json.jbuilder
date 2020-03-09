if @user.errors.any?
  json.ok false
  json.err @user.errors
else
  json.user do
    json.ok true
    json.id @user.id
    json.username @user.username
    json.email @user.email
    json.first_name @user.first_name
    json.last_name @user.last_name
  end
end
