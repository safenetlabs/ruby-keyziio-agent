require 'rest-client'
require 'json'

module Keyziio
  class Agent

    # Note: not passing through standard exceptions - an enhancement would be to return
    # meaningful exceptions for expected failure cases (bad auth, no connection, etc.)

    attr_accessor :id, :secret, :base_url, :token_hash, :token_end_time

    def check_or_get_token
      if !(self.token_hash).nil?
        return true # already have one
      end

      uri = URI.parse("#{base_url}/oauth2/token")
      uri.user = id
      uri.password = secret
      begin
        response = RestClient.post(uri.to_s , {:grant_type => "client_credentials"}.to_json, {:content_type => :json, :accept => :json})
        self.token_hash = JSON.parse(response)
      rescue SocketError, RestClient::Unauthorized
        false
      end
    end

    def initialize(id, secret, base_url = 'https://keyziio2.herokuapp.com/api/v1')
      self.base_url = base_url
      self.id = id
      self.secret = secret
      self.check_or_get_token # Not really necessary here, but why not get it early
    end

    def check
      if !self.check_or_get_token
        return false
      end

      begin
        url = "#{base_url}/oauth2/token/info"
        RestClient.get url, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      rescue SocketError, RestClient::Unauthorized
        false
      end
    end

    def get_user (id)
      if !self.check_or_get_token
        return false
      end

      begin
        url = "#{base_url}/users/#{id}?api_token=#{api_token}"
        RestClient.get url, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      rescue SocketError, RestClient::Unauthorized
        false
      end
    end

    def create_keychain (id, friendly_name)
      begin
        url = "#{base_url}/api/v1/agent/keychains"
        RestClient.post url, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      rescue RestClient::Unauthorized
        false
      end
    end
  end
end