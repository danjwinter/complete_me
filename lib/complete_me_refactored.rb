require 'pry'
class CompleteMe
  attr_accessor :links, :word, :data

  def initialize
    @root = Node.new("")
  end

  def push(data)
    @root.push(data)
  end

  def count
    @root.count
  end



  # def parsed_word(word)
  #   length = word.length
  #   arr = []
  #   counter = 0
  #   loop do
  #     arr << word[0..counter]
  #     counter += 1
  #     break if counter == length
  #   end
  #   arr
  # end
end

class Node
  attr_reader :links
  attr_accessor :rank, :name, :word_indicator

  def initialize(data, name=data[0])
    @data = data
    @links = {}
    @word_indicator = false
    @rank = 0
  end


  def push(data, counter=0)
    current_position_key  = links[data[0..counter]]

    if node_doesnt_exist?(current_position_key)
      current_position_key = Node.new(data[0..counter + 1])
      # no_word_match_protocol(current_position_key, data, counter)
      # return current_position_key
    end

    no_word_match_protocol(current_position_key, data, counter)
  end

  def no_word_match_protocol(current_position_key, data, counter)
    if data[counter+2] == nil
      # binding.pry
      # self.word_indicator = true
      current_position_key.word_indicator = true
    else
      current_position_key.push(data, counter + 1)
    end
  end

  def node_doesnt_exist?(key)
    key == nil
  end

  def count
    # binding.pry
    if word_indicator == true
      # binding.pry
      1 + links.keys.count
      if links != {}
        links.keys.count
      end
    else
      binding.pry
      0 + links.keys.count
    end
  end
end


  #
  #     if left == nil
  #       @left = node
  #     else
  #       left.push(node)
  #     end
  #   end
  # end

#   def push_right(node)
#     if data < node.data
#       if right == nil
#         @right = node
#       else
#         right.push(node)
#       end
#     else
#       return
#     end
#   end
#
#   def count
#     if left && right
#       1 + left.count + right.count
#     elsif left && !right
#       1 + left.count
#     elsif right && !left
#       1 + right.count
#     else
#       1
#     end
#   end
#
#   def sort
#     if left.nil? && right.nil?
#       [self.data]
#     elsif left.nil?
#       [self.data] + right.sort
#     elsif right.nil?
#       left.sort + [self.data]
#     else
#       left.sort + [self.data] + right.sort
#     end
#   end
#
#   def max
#     if right.nil?
#       return self.data
#     else
#       right.max
#     end
#   end
#
#   def min
#     if left.nil?
#       return self.data
#     else
#       left.min
#     end
#   end
#
#   def depth_of(value, counter=0)
#     if self.include?(value) == false
#       return false
#     else
#       counter += 1
#      if self.data == value
#        return counter
#      elsif self.data > value
#        left.depth_of(value, counter)
#      elsif self.data < value
#       right.depth_of(value, counter)
#      end
#    end
#   end
#
#   def include?(value)
#    if self.data == value
#      return true
#    elsif self.data > value
#      left.include?(value)
#    elsif self.data < value
#     right.include?(value)
#    else
#       false
#    end
#   end
# end



#   def create_links(word)
#     length = word.length
#     counter = 0
#     arr = parsed_word(word)
#     loop do
#       arr[-1] = arr[-1] + "*"
#       if @autocomplete[arr[counter]] == true
#         autocomplete[arr[counter]] += arr[counter..-1]
#       else
#         @autocomplete[arr[counter]] = arr[counter..-1]
#         counter += 1
#       end
#       break if counter == length
#     end
#     @autocomplete
#   end
#
#   def find(prefix)
#     possible_words = @autocomplete[prefix]
#     actual_words = possible_words.map do |word|
#       if word.include?("*")
#         word
#       end
#     end
#     binding.pry
#     actual_words.compact.delete("*")
#   end
# end

# class Node
# attr_reader :links
#
# end