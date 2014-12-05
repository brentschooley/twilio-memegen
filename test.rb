require_relative 'memegen'
require 'test/unit'

class FirstTest < Test::Unit::TestCase
  def test_to_phone
    message = "test meme, to:1(484) 560-2782"
    case message.downcase
    when /,\s?to:\s?(.*)/
      target = $1.strip
      message = message.gsub(/,\s?to:\s?(.*)/,'')
    end
    assert_equal('1(484) 560-2782', target)
    assert_equal('test meme', message)
  end

  def test_phonelib
    phone = Phonelib.parse('1(555) 555-5555    ')
    assert_equal('+15555555555',phone.international)
    phone = Phonelib.parse('a').international
    assert_equal(nil, phone)
  end
end
