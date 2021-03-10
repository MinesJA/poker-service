require 'singleton'


class Enum
  include Singleton
  attr_accessor :struct, :enums

  private

  def self.meta_attr(*attrs)
    self.instance.struct = Struct.new(:name, *attrs)
  end

  def self.enum_attr(name, *args)
    self.instance.enums[name] = self.instance.struct.new(name, *args)

    define_method(name) do
      self.instance.enums[:name]
    end
  end

  public

  def initialize()
    @enums = {}
  end

  def self.all()
    self.instance.enums.values
  end

  def self.of(name)
    self.instance.enums[name]
  end

end

# Another way that might be worth investigating:
# From: https://stackoverflow.com/questions/75759/how-to-implement-enums-in-ruby
# 
# class Enum
#     def self.new(values = nil)
#       enum = Class.new do
#         unless values
#           def self.const_missing(name)
#             const_set(name, new(name))
#           end
#         end
  
#         def initialize(name)
#           @enum_name = name
#         end
  
#         def to_s
#           "#{self.class}::#@enum_name"
#         end
#       end
  
#       if values
#         enum.instance_eval do
#           values.each { |e| const_set(e, enum.new(e)) }
#         end
#       end
  
#       enum
#     end
#   end
  
#   Genre = Enum.new %w(Gothic Metal) # creates closed enum
#   Architecture = Enum.new           # creates open enum
  
#   Genre::Gothic == Genre::Gothic        # => true
#   Genre::Gothic != Architecture::Gothic # => true