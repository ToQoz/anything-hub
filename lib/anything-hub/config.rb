module AnythingHub
  extend self

  class Config
    def method_missing(action, *args)
      if args.first
        instance_variable_set("@#{action.to_s}", args.first)
      else
        instance_variable_get("@#{action.to_s}")
      end
    end
  end

  def configure
    yield config
  end

  def config
    @config ||= AnythingHub::Config.new
  end
end
