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
    if self.is_sequence?(&block) || self.size <= 1
      seqs.push(self)
    else
      arrs = self.each_slice( (self.size/2.0).round ).to_a
      seqs = seqs + arrs[0].sequences(&block) + arrs[1].sequences(&block)
    end  

    if seqs.size < 2
      return seqs
    else
      new_seq = []
      indexes = seqs.size-1  
      indexes.times { |i| 
        merged = seqs[i] + seqs[i+1]
        if merged.is_sequence?(&block)
          new_seq.pop()
          new_seq.push(merged)
        else
          new_seq.push(seqs[i])
          new_seq.push(seqs[i+1])
        end
      }
    end
    return new_seq
  end

  def frequency(&block)
    p = Hash.new(0); each{ |v| p[block_given? ? block.call(v) : v] += 1 }; p
  end

  # def group_by_frequency(&block)
  #   p = Hash.new(0)
  #   each{ |v| p[block_given? ? block.call(v) : v] += 1 }
  #   p
  # end
end

  
  