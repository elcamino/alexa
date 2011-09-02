
module Alexa

  require 'nokogiri'
  # require 'alexa/container'
  require 'alexa/traffic_history/historical_data'

  class TrafficHistory

    attr_reader :historical_data, :range, :site, :start

    def initialize(data = {})
      @options = {
        'Action'           => 'TrafficHistory',
        'AWSAccessKeyId'   => Alexa.config.access_key_id,
        'Timestamp'        => ( Time::now ).utc.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
        'ResponseGroup'    => 'History',
        'SignatureVersion' => 2,
        'SignatureMethod'  => 'HmacSHA256',
        'Version'          => '2005-07-11',
        'Range'            => nil,
        'StartDate'        => nil,
        'Url'              => nil,
      }

      if data['historical_data']
        @historical_data = data['historical_data']
      end

      if data['range']
        @range = data['range']
      end

      if data['site']
        @site = data['site']
      end

      if data['start']
        @start = data['start']
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

      @range = data.xpath('//TrafficHistory/Range').first.text.strip
      @site  = data.xpath('//TrafficHistory/Site').first.text.strip
      @start = data.xpath('//TrafficHistory/Start').first.text.strip
      @historical_data = HistoricalData.new(data.xpath('//HistoricalData').first)

      self
    end

    def self.to_mongo(value)
      return nil   if value.nil?
      return value if value.is_a? Hash

      return {
        'range'           => value.range.to_s,
        'site'            => value.site.to_s,
        'start'           => value.start.to_s,
        'historical_data' => value.historical_data.to_mongo,
      }
    end

    def self.from_mongo(value)
      return nil   if value.nil?
      return value if value.is_a?(self)

      self.new('range'           => value['range'],
               'site'            => value['site'],
               'start'           => value['start'],
               'historical_data' => HistoricalData.from_mongo(value['historical_data']))
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
