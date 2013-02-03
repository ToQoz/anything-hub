module AnythingHub
  def cache(cache_key, &api)
    unless options[:cache] == "no"
      cache_data = JSON.parse(cache.read(cache_key)) rescue nil
    end
    if cache_data
      cache_data
    else
      response = api.call
      cache_store.write cache_key, response.to_json
      response
    end
  end

  command_set do
    command :starred do |input|
      _, username = input.split(':')
      cache(input) do
        github.starred(username || github.client.login).map do |repo|
          "(#{repo.full_name}) #{repo.description} [#{repo.html_url}]"
        end
      end
    end

    command :search do |input|
      _, query = input.split(':')
      cache(input) do
        github.search_repositories(query).map do |repo|
          "(#{repo.username}/#{repo.name}) #{repo.description} [http://github.com/#{repo.username}/#{repo.name}]"
        end
      end
    end

    command :token do |input|
      puts token
      nil
    end

    command :cache do |input|
      _, target_cmd = input.split(':', 2)
      cache_store.write target_cmd, nil
      cache_store.write target_cmd, command(target_cmd).to_json
      nil
    end
  end
end
