require_relative 'memegen'
require 'test/unit'

class FirstTest < Test::Unit::TestCase
  def test_to_phone
    message = "test meme, to:1(484) 560-2782"
    case message.downcase
    when /,\s?to:\s?(.*)/
      target = to_phone($1.strip)
      message = message.gsub(/,\s?to:\s?(.*)/,'')
    end
    assert_equal('+14845602782', target)
    assert_equal('test meme', message)
  end
end
