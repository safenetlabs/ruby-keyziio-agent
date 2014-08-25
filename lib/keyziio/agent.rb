require 'rest-client'
require 'json'

module Keyziio
  class Agent

    attr_accessor :api_token, :base_url

    def initialize(api_token, base_url = 'https://keyziio.herokuapp.com/api/v1')
      self.api_token = api_token
      self.base_url = base_url
    end

    def check
      begin
        url = "#{base_url}/check?api_token=#{api_token}"
        RestClient.get url, :accept => 'application/json'
      rescue RestClient::Unauthorized
        false
      end
    end

    def get_user (id)
      begin
        url = "#{base_url}/users/#{id}?api_token=#{api_token}"
        RestClient.get url, :accept => 'application/json'
      rescue RestClient::Unauthorized
        false
      end
    end

    def create_user (id, friendly_name)
      begin
        url = "#{base_url}/users?api_token=#{api_token}"
        RestClient.post url, {'asp_id' => id, 'friendly_name' => friendly_name}, :accept => :json
      rescue RestClient::Unauthorized
        false
      end
    end
  end
end
