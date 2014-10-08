json.array!(current_user.user_friendships) do |f|
json.friend f.friend
end