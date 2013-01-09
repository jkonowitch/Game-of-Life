module Math
  def self.cartesian(*args)
    res = args.shift

    while args.length > 0
      next_set = args.shift
      res = res.product(next_set).map { |s| s.flatten }
    end

    res
  end
end