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

  def suggest(prefix, counter=0, ranking_array=[])
    if word_indicator == true && data.include?(prefix)
      if ranking_array.empty? || ranking_array[counter].nil?
        ranking_array << self
      end
    else
      links.values[0].suggest(prefix, counter, ranking_array)
    end
    return ranking_array
  end
end
