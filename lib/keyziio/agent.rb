require 'rest-client'

module Keyziio
  class Agent

    attr_accessor :api_token, :base_url

    def initialize(api_token, base_url: 'https://keyziio.herokuapp.com/api/v1')
      self.api_token = api_token
      self.base_url = base_url
    end

    def check
      begin
        RestClient.get "#{base_url}/check?api_token=#{api_token}"
      rescue RestClient::Unauthorized
        false
      end
    end

  end
end
