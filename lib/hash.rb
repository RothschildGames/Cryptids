class Hash

  def keys_with_maximum_value
    select{|_, v| v == max_value}.keys
  end

  def max_value
    values.max
  end

  def weights
    last_weight = 0
    self.inject({}) do |hash, (k,v)|
      hash[k] = (last_weight...(last_weight+v))
      last_weight = hash[k].last
      hash
    end
  end

end