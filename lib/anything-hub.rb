require 'json'
require 'octokit'
require 'ruby-anything'
require 'active_support/cache'
require "anything-hub/version"

module AnythingHub
  extend self

  attr_accessor :options

  HOME_RC_FILE = '~/.anything-hubrc'

  def run(input, opts = {})
    init
    self.options = opts

    if (results = command(input))
      cache.write(input, results.to_json)
      system("#{options[:s]} #{_anything_(results).gsub(/.*\[(.*)\]/, '\1')}")
    end
  end

  def init
    require "anything-hub/config"
    load HOME_RC_FILE
    require "anything-hub/github"
    require "anything-hub/command_set"
    require "anything-hub/commands"
  end

  def app_dir
    dir = File.expand_path('~/.anything-hub')
    Dir.mkdir(dir) unless Dir.exists? dir
    @app_dir ||= dir
  end

  def token
    unless (_token = cache.read('authorizations:token') || config.token)
      res = `curl \
        --data '{"scopes":["repo"]}' \
        --request POST -u '#{config.login}' \
        https://api.github.com/authorizations`
      _token = (JSON.parse(res) rescue nil).try(:[], 'token')
      raise StandardError, 'invalid password' if _token.blank?
      cache.write 'authorizations:token', _token
    end
    @token ||= _token
  end

  def cache
    @cache ||= ActiveSupport::Cache::FileStore.new(File.join(app_dir, 'cache'))
  end
end
