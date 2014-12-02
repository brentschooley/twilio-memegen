require_relative 'memegen'
require 'test/unit'

class FirstTest < Test::Unit::TestCase

  def test_not_impressed_blank
    meme = match_memes("-not impressed-")
    puts "not impressed"
    puts meme
    assert_equal(meme[:top], "")
    assert_equal(meme[:bottom], "not impressed")
  end

  def test_not_impressed_top_only
    meme = match_memes("i am-not impressed-")
    puts meme
    assert_equal(meme[:top], "i am")
    assert_equal(meme[:bottom], "not impressed")
  end

  def test_not_impressed_bottom_only
    meme = match_memes("-not impressed-not impressed")
    puts meme
    assert_equal(meme[:top], "")
    assert_equal(meme[:bottom], "not impressed")
  end

  def test_not_impressed_top_bottom
    meme = match_memes("i am-not impressed-not impressed")
    puts meme
    assert_equal(meme[:top], "i am")
    assert_equal(meme[:bottom], "not impressed")
  end

  def test_not_impressed_trims
    meme = match_memes(" i am -not impressed- not impressed ")
    puts meme
    assert_equal(meme[:top], "i am")
    assert_equal(meme[:bottom], "not impressed")
  end

  def test_no_time
    meme = match_memes("bed time-no time-")
    puts meme
    assert_equal(meme[:top], "bed time")
    assert_equal(meme[:bottom], "ain't nobody got time for that")

    meme = match_memes("-no time-")
    assert_equal(meme[:top], "")
    assert_equal(meme[:bottom], "ain't nobody got time for that")

    meme = match_memes("-no time-this won't show")
    assert_equal(meme[:top], "")
    assert_equal(meme[:bottom], "ain't nobody got time for that")
  end

  def test_escaleted
    meme = match_memes("testing-escalated-")
    assert_equal(meme[:top], "testing")
    assert_equal(meme[:bottom], "boy, that escalated quickly")

    meme = match_memes("testing-escalated-again")
    assert_equal(meme[:top], "testing")
    assert_equal(meme[:bottom], "boy, that escalated quickly")

    meme = match_memes("-escalated-")
    assert_equal(meme[:top], "")
    assert_equal(meme[:bottom], "boy, that escalated quickly")
  end

  def test_simply
    meme = match_memes("testing-simply-testing")
    assert_equal(meme[:top], "one does not simply")
    assert_equal(meme[:bottom], "testing")

    meme = match_memes("testing-simply-")
    assert_equal(meme[:top], "one does not simply")
    assert_equal(meme[:bottom], "")

    meme = match_memes("-simply-")
    assert_equal(meme[:top], "one does not simply")
    assert_equal(meme[:bottom], "")
  end

  def test_morpheus
    meme = match_memes("testing-morpheus-testing")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "testing")

    meme = match_memes("testing-morpheus-")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "")

    meme = match_memes("-morpheus-")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "")
  end

  def test_what_if_i_told_you
    meme = match_memes("testing-told you-testing")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "testing")

    meme = match_memes("testing-told you-")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "")

    meme = match_memes("-told you-")
    assert_equal(meme[:top], "what if i told you")
    assert_equal(meme[:bottom], "")
  end

  def test_brace
    meme = match_memes("testing-brace yourselves-memes are coming")
    assert_equal(meme[:top], "brace yourselves")
    assert_equal(meme[:bottom], "memes are coming")

    meme = match_memes("-brace yourselves-memes are coming")
    assert_equal(meme[:top], "brace yourselves")
    assert_equal(meme[:bottom], "memes are coming")

    meme = match_memes("-brace yourselves-")
    assert_equal(meme[:top], "brace yourselves")
    assert_equal(meme[:bottom], "")
  end

  def test_business
    meme = match_memes("testing-business-")
    assert_equal(meme[:top], "testing")
    assert_equal(meme[:bottom], "but that's none of my business")
  end

  def test_all_the_things
    meme = match_memes("meme-all the-")
    assert_equal("meme", meme[:top])
    assert_equal("all the things", meme[:bottom])

    meme = match_memes("eat-all the-turkey")
    assert_equal("eat", meme[:top])
    assert_equal("all the turkey", meme[:bottom])
  end

  def test_badass
    meme = match_memes("watch out-badass-")
    assert_equal(meme[:top], "watch out")
    assert_equal(meme[:bottom], "we got a badass over here")
  end

  def test_its_gone
    meme = match_memes("testing-gone-")
    assert_equal(meme[:top], "testing")
    assert_equal(meme[:bottom], "aaaand it's gone")
  end

  def test_mvp
    meme = match_memes("test-mvp-test")
    assert_equal(meme[:top], "test")
    assert_equal(meme[:bottom], "you da real mvp")
  end

end
