require 'pry'
class CompleteMe
  attr_accessor :root

  def initialize
    @root = Node.new("")
  end

  def insert(data)
    @root.insert(data)
  end

  def count
    @root.count
  end

  def suggest(prefix)
    @root.suggest(prefix)
  end
end

class Node
  attr_reader :links, :data
  attr_accessor :word_indicator

  def initialize(data)
    @data = data
    @links = {}
    @word_indicator = false
    @rank = 0
  end


  def insert(value, counter=0)
    if links[value[0..counter]].nil?
      links[value[0..counter]] = Node.new(value[0..counter])
    end
    if value[counter + 1].nil?
      links[value[0..counter]].word_indicator = true
    else
      links[value[0..counter]].insert(value, counter + 1)
    end
  end

  def continue_processing(data, counter)
    # word = links[data[0..counter]]
    # binding.pry
    # if data[counter + 2] == nil
    #   # binding.pry
    #   # self.word_indicator = true
    #   # links[data[0..counter]]
    #   word.word_indicator = true
      # binding.pry
      # @root.insert_into_ranking_array(self.links.values[0])
    #   # rank_words(word)
    # else
    #  ### links[data[0..counter]].push(data, counter + 1)
    # end
  end

  # def insert_into_ranking_array(node)
  #   binding.pry
  #   if node.data == data
  #     rank_words(node)
  #   elsif word_indicator == true
  #     binding.pry
  #     rank_words(node)
  #   else
  #     links.values[0].insert_into_ranking_array(value)
  #   end
  # end

  # def rank_words(word, counter=0)
  #   if word.ranking_array.empty? || word.ranking_array[counter] == nil
  #     word.ranking_array << word
  #   elsif word.rank > ranking_array[counter].rank
  #     word.ranking_array.insert(word, counter)
  #   else
  #     rank_words(word, counter + 1)
  #   end
  # end

  def count
    if data == "" && links.empty?
      0
    elsif links.empty?
      1
    elsif word_indicator == true
      1 + (links.values.each {|value| value.count}).reduce(&:+)
    else
      (links.values.each {|value| value.count}).reduce(&:+)
    end
  end

  def suggest(prefix, counter=0, ranking_array=[])
    if word_indicator == true && data.include?(prefix)
      if ranking_array.empty? || ranking_array[counter].nil?

        ranking_array << self
      # elsif rank >= ranking_array[counter].rank
      #   ranking_array.insert(self, counter)
      # else
      #   suggest(prefix, counter + 1)
      end
    # elsif links.empty?
    #   "not a prefix"
    else
      links.values[0].suggest(prefix, counter, ranking_array)
    end
    # binding.pry
    return ranking_array
  end

  #
  # def continue_processing(data, counter)
  #   word = links[data[0..counter]]
  #   if data[counter + 2] == nil
  #     # binding.pry
  #     # self.word_indicator = true
  #     # links[data[0..counter]]
  #     word.word_indicator = true
  #     rank_words(word)
  #   else
  #     links[data[0..counter]].push(data, counter + 1)
  #   end
  # end

end


    # if word_indicator == true
    #   # binding.pry
    #   1 + links.keys.count
    #   if links != {}
    #     links.keys.count
    #   end
    # else
    #   0 + links.keys.count
    # end

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