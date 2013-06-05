class Hash

  def keys_with_maximum_value
    max_value = values.max
    select{|_, v| v == max_value}.keys
  end

  def weights_hash
    last_weight = 0
    self.inject({}) do |hash, (k,v)|
      hash[k] = last_weight + v
      last_weight = hash[k]
      hash
    end
  end

end