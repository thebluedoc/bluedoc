json.cache! ["1.0", user] do
  json.(user, :id, :slug, :name)
  json.avatar_url user.avatar_url
end