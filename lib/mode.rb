class Array
  def mode
    sort_by {|i| grep(i).length }.last
  end

  def percent_of(i)
    grep(i).length * 100.0 / self.length
  end
end