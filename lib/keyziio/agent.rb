require 'rest-client'
require 'json'

module Keyziio
  class Unauthorized < StandardError
  end

  class ServerError < StandardError
  end

  class ResourceNotFound < StandardError
  end

  class Agent

    attr_accessor :id, :secret, :base_url, :token_hash

    def check_or_get_token
      if !(self.token_hash).nil?
        return true # already have one
      end

      uri = URI.parse("#{base_url}/oauth2/token")
      uri.user = id
      uri.password = secret
      response = RestClient.post(uri.to_s , {:grant_type => "client_credentials"}.to_json, {:content_type => :json, :accept => :json})
      self.token_hash = JSON.parse(response)
    end

    def initialize(id, secret, base_url = 'https://keyziio2.herokuapp.com/api/v1')
      self.base_url = base_url
      self.id = id
      self.secret = secret
      begin
        self.check_or_get_token # Not really necessary here, but why not get it early.  Ignore expected exceptions
      rescue SocketError, RestClient::Unauthorized
        true
      end
    end

    def check
      begin
        self.check_or_get_token
        url = "#{base_url}/oauth2/token/info"
        RestClient.get url, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      rescue RestClient::Unauthorized
        raise Unauthorized
      rescue SocketError => e
        raise ServerError, e.message
      end
    end

    def get_keypart
      url = "#{base_url}/hsm/keyparts"
      response = RestClient.post url,{}, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      JSON.parse(response)["bytes"]
    end

    def create_keychain (name)
      begin
        self.check_or_get_token
        keypart = self.get_keypart
        url = "#{base_url}/agent/keychains"
        response = RestClient.post url,{:name => name, :keypart => keypart}, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
        JSON.parse(response)["id"]
      rescue RestClient::Unauthorized
        raise Unauthorized
      rescue SocketError => e
        raise ServerError, e.message
      end
    end

    def get_keychain (id)
      begin
        self.check_or_get_token
        url = "#{base_url}/agent/keychains/#{id}"
        response = RestClient.get url, {:accept => :json, :authorization => "Bearer #{token_hash['access_token']}"}
      rescue RestClient::Unauthorized
        raise Unauthorized
      rescue SocketError => e
        raise ServerError, e.message
      rescue RestClient::ResourceNotFound => e
        raise ResourceNotFound, e.message
      end
      
    end
  end
end