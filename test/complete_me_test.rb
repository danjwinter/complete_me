require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'
require 'pry'

class CompleteMeTest < Minitest::Test

  def setup
    @complete = CompleteMe.new
  end

  def test_it_can_parse_word
    assert_equal ["w", "wo", "wor", "word"], @complete.parsed_word("word")
  end

  def test_it_can_push_word
    assert_equal 0, @complete.push("word")
  end
  # def test_it_adds_to_hash_when_adding_words_and_does_not_override
  #   @complete.create_hash("words")
  #   @complete.create_hash("words")
  #   assert_equal ["wo", "wor", "word", "words"], @complete.autocomplete["wo"]
  # end
end