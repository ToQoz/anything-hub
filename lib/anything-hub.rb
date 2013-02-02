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

  def cache
    @cache ||= ActiveSupport::Cache::FileStore.new('/tmp/anything-hub.log')
  end
end
