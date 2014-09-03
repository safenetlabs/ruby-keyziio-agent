require_relative 'minitest_helper'
require 'keyziio/agent'

require 'securerandom'

class TestKeyziio < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Keyziio::VERSION
  end

  def test_initialization
    assert Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
  end

  def test_check
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert agent.check
  end

  def test_check_bad_creds
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', 'badpassword')
    refute agent.check
  end

  def test_check_no_connection
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d','https://www.notarealsiteihope.com')
    refute agent.check
  end

  def test_create_keychain
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert agent.check

  end

  def test_get_a_keychain_which_isnt_there

  end


  #
  # def test_create_user
  #
  # end

  #
  # def test_failed_check
  #   VCR.use_cassette('failed_test_check') do
  #     agent = Keyziio::Agent.new('invalid')
  #     refute agent.check
  #   end
  # end

  # def test_check_no_connection
  #   VCR.use_cassette('test_check_no_connection') do
  #     agent = Keyziio::Agent.new('yrDIo1JeXlR74FGpyHyi') #, 'http://keyziio.herokuapp.com/willnotbefound')
  #     assert_raises RestClient::ResourceNotFound do
  #       agent.check
  #     end
  #   end
  # end

  # def test_get_user
  #   agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
  #   agent.get_user('billy')
  # end
  #
  # def test_create_user
  #   agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
  #   p = SecureRandom.hex
  #   agent.create_user(p, 'friendly')
  # end

end
