module AnythingHub
  extend self

  def command_set(&block)
    class_eval(&block)
  end

  def command(name, &block)
    if block
      commands << {:pattern => /^#{name}(:.+)?/, :block => block}
    else
      cmd = commands.detect { |c| c[:pattern] =~ name }
      cmd[:block].call(name)
    end
  end

  def commands
    @commands ||= []
  end

  def fetch_from_api_or_cache(cache_key, &api)
    unless options[:cache] == "no"
      cache_data = JSON.parse(cache.read(cache_key)) rescue nil
    end
    if cache_data
      cache_data
    else
      response = api.call
      cache.write cache_key, response.to_json
      response
    end
  end
end
