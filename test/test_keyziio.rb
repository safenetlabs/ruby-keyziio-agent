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
    assert_raises Keyziio::Unauthorized do
      agent.check
    end
  end

  def test_check_no_connection
    assert_raises Keyziio::ServerError do
      agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d','https://www.notarealsiteihope.com')
      refute agent.check
    end
  end

  def test_create_keychain
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert agent.check
    assert agent.create_keychain("name")
  end

  def test_get_keychain
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert agent.check
    id = agent.create_keychain("myname")
    assert agent.get_keychain(id)
  end

  def test_get_a_keychain_which_isnt_there
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert_raises Keyziio::ResourceNotFound do
      agent.get_keychain("72188084-fb5f-445c-901e-05afcee24a9f")
    end
  end

  def test_get_keychain_client_scoped_token
    agent = Keyziio::Agent.new('b4393ce46503757f5753281b1e0ab64d9d10fd2652e4eee683fd17054590e605', '919c9236eb16d9b52b06eed69c27b5cbbdf6a23e9c27c3cf221684906f83948d')
    assert agent.check
    id = agent.create_keychain("myname")
    token = agent.get_client_token(id)
    true
  end

end
