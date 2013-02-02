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
end
