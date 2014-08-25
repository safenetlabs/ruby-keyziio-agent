require 'keyziio'

require 'securerandom'

class TestKeyziio 
  def test_get_user
    agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
    agent.get_user('u15')
  end

  def test_create_user
    agent = Keyziio::Agent.new('cnZNqHoOXDML9eSSZI')
    #p = SecureRandom.hex
    agent.create_user('u16', 'friendly_u16')
  end
end

if __FILE__ == $0
  kztest = TestKeyziio.new
  response = kztest.test_create_user
  print response
  response = kztest.test_get_user
  print response
end
