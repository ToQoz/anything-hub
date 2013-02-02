module AnythingHub
  extend self

  class Github
    def initialize(login, password)
      @login = login
      @password = password
    end

    def client
      @client ||= Octokit::Client.new :login => @login, :password => @password, :auto_traversal => true
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
    @github ||= Github.new(config.login, config.password)
  end
end
