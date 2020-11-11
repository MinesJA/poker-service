class Array
    # Slices over an array, 2 elements at a time
    # Overlapping iteration
    def slice_over
      # Need t
      new_arr = []
      indexes = self.size-1
      indexes.times {|i| new_arr.push(yield(self[i], self[i+1]))}
      return new_arr
    end
  
    def is_sequence?
      return self.sort_by {|item| block_given? ? yield(item) : item }
        .reverse
        .map {|item| block_given? ? yield(item) : item }
        .slice_over {|x, y| x - y }
        .none? {|i| i != 1 }
    end
  
    def sequences
      seqs = []
      if self.is_sequence? || self.size <= 1
        seqs.push(self)
      else
        arrs = self.each_slice( (self.size/2.0).round ).to_a
        seqs = seqs + arrs[0].sequences + arrs[1].sequences
      end  
  
      if seqs.size < 2
        return seqs
      else
        new_seq = []
        indexes = seqs.size-1  
        indexes.times { |i| 
          merged = seqs[i] + seqs[i+1]
          if merged.is_sequence?
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
  end
  
  