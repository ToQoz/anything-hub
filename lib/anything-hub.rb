require 'json'
require 'octokit'
require 'ruby-anything'
require 'active_support/cache'
require "anything-hub/version"

module AnythingHub
  extend self

  HOME_RC_FILE = '~/.anything-hubrc'

  def run(input, opts = {})
    init

    begin
      unless opts[:cache] == "no"
        urls = JSON.parse(cache.read(input))
      end
    rescue
    end

    unless urls
      urls = command(input)
      cache.write input, urls.to_json
    end

    system("#{opts[:s]} #{_anything_(urls)}")
  end

  def init
    require "anything-hub/config"
    load HOME_RC_FILE
    require "anything-hub/github"
    require "anything-hub/command_set"
    require "anything-hub/commands"
  end

  def cache
    @cache ||= ActiveSupport::Cache::FileStore.new('/tmp/anything-hub.log')
  end
end
