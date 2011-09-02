
module Alexa

  require 'nokogiri'
  require 'alexa/container'
  require 'alexa/sites_linking_in/site'

  class SitesLinkingIn

    attr_reader :links

    def initialize(data = { })
      @options = {
        'Action'           => 'SitesLinkingIn',
        'AWSAccessKeyId'   => Alexa.config.access_key_id,
        'Timestamp'        => ( Time::now ).utc.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
        'ResponseGroup'    => 'SitesLinkingIn',
        'SignatureVersion' => 2,
        'SignatureMethod'  => 'HmacSHA256',
        'Version'          => '2005-07-11',
        'Count'            => nil,
        'Start'            => nil,
        'Url'              => nil,
      }

      if data['links']
        @links = data['links']
      end

      if Alexa.config.proxy
        RestClient.proxy = Alexa.config.proxy
      end
    end

    def signature
      Alexa.sign(@options)
    end

    def url
      qs = Alexa.query_string(@options)
      'http://' + ::Alexa::SERVICE_HOST + '/?' + qs + '&Signature=' + signature
    end

    def fetch(options = {})
      @options.merge!(options)
      @options.delete_if { |k,v| v.nil? }

      raise ArgumentException.new('Url field is empty!') unless @options['Url']

      response = RestClient.get(url)
      data = Nokogiri::XML(response.to_s)
      data.remove_namespaces!

      @links = []

      data.xpath('//SitesLinkingIn/Site').each do |s|
        @links << ::Alexa::SitesLinkingIn::Site.new(s)
      end

      self
    end

    def self.to_mongo(value)
      return nil   if value.nil?
      return value if value.is_a? Hash

      return {
        'links' => value.links.map { |l| SitesLinkingIn::Site.to_mongo(l) },
      }
    end

    def self.from_mongo(value)
      return nil if value.nil?
      return value if value.is_a?(self)

      links = []
      value['links'].each do |l|
        links << SitesLinkingIn::Site.from_mongo(l)
      end

      self.new('links' => links)
    end

    def to_mongo
      self.class.to_mongo(self)
    end


    #
    # Exceptions
    #

    class ArgumentException < Exception
    end
  end


end
