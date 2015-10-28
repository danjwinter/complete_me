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
    arr = source.split("\n")
    arr.each do |entry|
      @root.insert(entry)
    end
  end

  def contain(prefix)
    @root.contain(prefix)
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
    ranking_array
  end

  def suggest(prefix)
    new_arr = find_words_with_prefix_rank(prefix).map do |word_rank_pair|
      word_rank_pair[0]
    end
    new_arr
  end

  def find_words_with_prefix_rank(prefix, counter=0, ranking_array=[])
    if word_indicator == true && data.start_with?(prefix)
      if ranking_array.empty? || ranking_array[counter].nil?
        ranking_array << [self.data, self.rank]
      elsif rank > ranking_array[counter][1]
        ranking_array.insert(counter, [self.data, self.rank])
      else
        find_words_with_rank(prefix, counter + 1, ranking_array)
      end
    end
      unless links.nil?
        links.values.map {|value| value.find_words_with_prefix_rank(prefix, counter, ranking_array)}
      end
    ranking_array
  end

  def select(prefix, word)
    if data == word
      self.rank += 1
    elsif links != {}
      links.values.each {|value| value.select(prefix, word)}
    end
  end
end
