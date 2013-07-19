module LastCall
  def last_call
    caller[1].match(/`(.*)'/)[1].to_sym
  end
end
