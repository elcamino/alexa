

module Alexa
  require 'uri'
  require 'base64'
  require 'openssl'

  require 'alexa/config'
  require 'alexa/url_info'
  require 'alexa/traffic_history'
  require 'alexa/sites_linking_in'

  SERVICE_HOST = 'awis.amazonaws.com'

  def self.uri_escape(input)
    URI.escape(input, /[^A-Za-z0-9\-_.~]/)
  end

  def self.query_string(options)
    options.keys.sort.map { |k| k + '=' + self.uri_escape(options[k].to_s) }.join('&')
  end

  def self.sign(options)
    sign_str  = "GET\n" + SERVICE_HOST + "\n/\n" + query_string(options)
    self.uri_escape(Base64.encode64( OpenSSL::HMAC.digest( OpenSSL::Digest::Digest.new( "sha256" ), Alexa.config.secret_access_key, sign_str)).strip)
  end

end
