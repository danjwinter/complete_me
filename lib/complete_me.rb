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

  def select(prefix, word)
    @root.select(prefix, word)
  end

  def populate(source)
    arr = source.downcase.split("\n")
    arr.each do |entry|
      @root.insert(entry)
    end
    nil
  end

  def contain(prefix)
    @root.contain(prefix)
  end

  def find_prefix(prefix)
    @root.find_prefix(prefix)
  end
end

class Node
  attr_reader :links, :data
  attr_accessor :word_indicator, :rank

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

  def count
    if data == "" && links.empty?
      0
    elsif links.empty?
      1
    elsif word_indicator == true
      1 + (links.values.map {|value| value.count}).reduce(&:+)
    else
      (links.values.map {|value| value.count}).reduce(&:+)
    end
  end

  def contain(prefix)
    new_arr = find_words_with_rank(prefix).map do |word_rank_pair|
      word_rank_pair[0]
    end
    new_arr
  end

  def find_words_with_rank(prefix, counter=0, ranking_array=[])
    if word_indicator == true && data.include?(prefix)
      if ranking_array.empty? || ranking_array[counter].nil?
        ranking_array << [self.data, self.rank]
      elsif rank > ranking_array[counter][1]
        ranking_array.insert(counter, [self.data, self.rank])
      else
        find_words_with_rank(prefix, counter + 1, ranking_array)
      end
    end
      unless links.nil?
        links.values.map {|value| value.find_words_with_rank(prefix, counter, ranking_array)}
      end
    ranking_array.uniq
  end

  def find_prefix(prefix, counter=0)
    # binding.pry
    if data == prefix
      return self
    elsif data == prefix[0..counter]
      links[prefix[0..counter + 1]].find_prefix(prefix, counter + 1)
    else
      unless links[prefix[0..counter]].nil?
        links[prefix[0..counter]].find_prefix(prefix, counter)
      # unless prefix[counter + 1].nil?
      #   links.values.each {|node| node.find_prefix(prefix, counter + 1)}
      end
    end
  end

  def suggest(prefix)
    start = find_prefix(prefix)
    new_arr = start.find_words_with_prefix_rank(prefix).map do |word_rank_pair|
      word_rank_pair[0]
    end
    new_arr
  end

  def find_words_with_prefix_rank(prefix, counter=0, ranking_array=[])
    # find_prefix(prefix)
    if word_indicator == true && data.start_with?(prefix)
      if ranking_array.empty? || ranking_array[counter].nil?
        unless ranking_array.include?([self.data, self.rank])
          ranking_array << [self.data, self.rank]
        end
      elsif rank > ranking_array[counter][1]
        unless ranking_array.include?([self.data, self.rank])
          ranking_array.insert(counter, [self.data, self.rank])
        end
      else
        find_words_with_rank(prefix, counter + 1, ranking_array)
      end
    end
      unless links.nil?
        links.values.map {|value| value.find_words_with_prefix_rank(prefix, counter, ranking_array)}
      end
    ranking_array.uniq
  end

  def select(prefix, word)
    if data == word
      self.rank += 1
    elsif links != {}
      links.values.each {|value| value.select(prefix, word)}
    end
    nil
  end
end
