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
      system("#{options[:s]} #{_anything_(results)}")
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

  def token_file
    @token_file ||= File.join(app_dir, 'token')
  end

  def token
    unless File.exists?(token_file)
      res = `curl \
        --data '{"scopes":["repo"]}' \
        --request POST -u '#{AnythingHub.config.login}' \
        https://api.github.com/authorizations`
      data = JSON.parse(res) rescue nil

      _token = data.try(:[], 'token')
      if _token.blank?
        puts 'invalid password'
        exit!
      end
      File.open(token_file, 'wb') { |f| f.write _token }
    end
    @token ||= File.open(token_file).read.chomp
  end

  def cache
    @cache ||= ActiveSupport::Cache::FileStore.new(File.join(app_dir, 'cache'))
  end
end
