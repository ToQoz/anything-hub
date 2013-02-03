AnythingHub.command_set do
  command :starred do |input|
    _, username = input.split(':')
    fetch_from_api_or_cache(input) do
      github.starred(username || github.client.login).map(&:html_url)
    end
  end

  command :search do |input|
    _, query = input.split(':')
    fetch_from_api_or_cache(input) do
      github.search_repositories(query).map do |repo|
        "http://github.com/#{repo.username}/#{repo.name}"
      end
    end
  end

  command :token do |input|
    puts token
    nil
  end

  command :cache do |input|
    _, target_cmd = input.split(':', 2)
    cache.write target_cmd, nil
    cache.write target_cmd, command(target_cmd).to_json
    nil
  end
end
