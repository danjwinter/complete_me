require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'
require 'pry'

class CompleteMeTest < Minitest::Test

  def setup
    @complete = CompleteMe.new
  end

  def test_it_can_push_word
    @complete.insert("word")
    # binding.pry
    assert_equal "w", @complete.root.links["w"].data
    assert_equal "wo", @complete.root.links["w"].links["wo"].data
    # binding.pry
    assert_equal "wor", @complete.root.links["w"].links["wo"].links["wor"].data
    assert_equal "word", @complete.root.links["w"].links["wo"].links["wor"].links["word"].data
    assert_equal({}, @complete.root.links["w"].links["wo"].links["wor"].links["word"].links)
  end

  def test_it_can_push_multiple_words_that_do_not_share_letters
    @complete.insert("ab")
    @complete.insert("cd")

    assert_equal "a", @complete.root.links["a"].data
    assert_equal "ab", @complete.root.links["a"].links["ab"].data
    assert_equal "c", @complete.root.links["c"].data
    assert_equal "cd", @complete.root.links["c"].links["cd"].data
  end

  def test_it_can_insert_multiple_words_that_share_letters
    @complete.insert("ab")
    @complete.insert("ad")
    assert_equal "a", @complete.root.links["a"].data
    assert_equal "ab", @complete.root.links["a"].links["ab"].data
    assert_equal "ad", @complete.root.links["a"].links["ad"].data
  end

  def test_it_can_flip_word_indicator
    @complete.insert("ab")
    @complete.insert("ad")
    assert @complete.root.links["a"].links["ab"].word_indicator
    assert @complete.root.links["a"].links["ad"].word_indicator
    refute @complete.root.links["a"].word_indicator
    @complete.insert("a")
    assert @complete.root.links["a"].word_indicator
  end

  def test_it_can_count_zero_words
    assert_equal 0, @complete.count
  end

  def test_it_can_count_one_word
    @complete.insert("ab")
    assert_equal 1, @complete.count
  end

  def test_it_can_count_multiple_words
    @complete.insert("ab")
    @complete.insert("ad")
    assert_equal 2, @complete.count
    @complete.insert("word")
    @complete.insert("words")
    @complete.insert("a")
    assert_equal 5, @complete.count
  end

  def test_it_can_suggest_words_from_prefix
    @complete.insert("word")
    assert_equal ["word"], @complete.suggest("w")

    @complete.insert("wombat")
    assert_equal ["word", "wombat"], @complete.suggest("w")
    @complete.insert("wally")
    assert_equal ["word", "wombat"], @complete.suggest("wo")
  end

  def test_it_changes_rank_when_selected
    @complete.insert("wacky")
    @complete.insert("walrus")
    @complete.select("w", "walrus")
    assert_equal ["walrus", "wacky"], @complete.suggest("w")
  end

end


#
# require 'csv'
#
# csv = csv.read('/addresses/addresses,csv', :headers=>true)
# csv["FULL_ADDRESS"] #this gives you array with addresses for each element