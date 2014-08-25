require_relative 'minitest_helper'
require 'keyziio/agent'

require 'securerandom'

class TestKeyziio < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Keyziio::VERSION
  end

  def test_check
    VCR.use_cassette('test_check') do
      agent = Keyziio::Agent.new('yrDIo1JeXlR74FGpyHyi')
      assert agent.check
    end
  end

  def test_failed_check
    VCR.use_cassette('failed_test_check') do
      agent = Keyziio::Agent.new('invalid')
      refute agent.check
    end
  end

  def test_check_no_connection
    VCR.use_cassette('test_check_no_connection') do
      agent = Keyziio::Agent.new('yrDIo1JeXlR74FGpyHyi') #, 'http://keyziio.herokuapp.com/willnotbefound')
      assert_raises RestClient::ResourceNotFound do
        agent.check
      end
    end
  end

  def test_get_user
    agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
    agent.get_user('billy')
  end

  def test_create_user
    agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
    p = SecureRandom.hex
    agent.create_user(p, 'friendly')
  end

end
