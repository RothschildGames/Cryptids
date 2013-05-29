class Hash

  def keys_with_maximum_value
    max_value = values.max
    select{|_, v| v == max_value}.keys
  end

end