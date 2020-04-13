json.ok true
json.status 200
json.data do 
  json.token WebToken.encode({user_id: @user.id})
  json.exp 24.hours.from_now.to_date.to_s
  json.username @user.username
  json.uuid @user.uuid
end
