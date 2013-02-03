module AnythingHub
  extend self

  class Github
    def initialize(login, oauth_token)
      @login = login
      @oauth_token = oauth_token
    end

    def client
      @client ||= Octokit::Client.new :login => @login, :oauth_token => @oauth_token, :auto_traversal => true
    end

    def method_missing(action, *args)
      if client.respond_to?(action.to_s)
        client.send(action, *args)
      else
        super
      end
    end
  end

  def github
    @github ||= Github.new(config.login, token)
  end
end
