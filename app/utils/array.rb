class Array

  # Slices over an array, overlapping 2 elements at a time
  def slice_over
    new_arr = []
    indexes = self.size-1
    indexes.times {|i| new_arr.push(yield(self[i], self[i+1]))}
    return new_arr
  end

  # Returns true if an array of numbers is a sequence, 
  #   regardless of order
  # Optionally, can pass a block to define how items 
  #   are evaluated
  # 
  # ===== EXAMPLES
  # [2,1,3].is_sequence? 
  #   => True
  # 
  # Data = Struct.new(:num)
  # 
  # [Data.new(2), Data.new(1), Data.new(3)].is_sequence?{|d| d.num}
  #   =? True
  # 
  def is_sequence?(&block)
    return self.sort_by {|item| block_given? ? block.call(item) : item }
      .reverse
      .map {|item| block_given? ? block.call(item) : item }
      .slice_over {|x, y| x - y }
      .none? {|i| i != 1 }
  end

  def sequences(&block)
    seqs = []
    last_ind = 0

    diff = -> (x,y) {
      if block_given?
        d = block.call(x) - block.call(y)
        return d
      else
        x - y
      end
    }
    sorted = block_given? ? self.sort_by(&block) : self.sort
    
    sorted.each_index do |i|
      if i == 0
        seqs.push([sorted[i]]) 
      elsif diff.call(sorted[i], sorted[i-1]) == 1
        seqs[last_ind].push(sorted[i])
      else
        seqs.push([sorted[i]])
        last_ind += 1
      end
    end
    return seqs
  end

  def frequency(&block)
    p = Hash.new(0); each{|v| p[block_given? ? block.call(v) : v] += 1 }; p
  end

  def group_by_frequency(&block)
    p = Hash.new([])

    new_block = -> x {block_given? ? block.call(x) : x}

    group_by(&new_block)
      .each{|k,v| p[v.size] = p[v.size] + v}

    return p
  end
end

  
  