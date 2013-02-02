AnythingHub.command_set do
  command :starred do |input|
    cmd_name, username = input.split(':')
    github.starred(username || github.client.login).map(&:html_url)
  end
  command :search do |input|
    cmd_name, query = input.split(':')
    github.search_repositories(query).map do |repo|
      "http://github.com/#{repo.username}/#{repo.name}"
    end
  end
end
